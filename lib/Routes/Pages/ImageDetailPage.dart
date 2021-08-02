import 'dart:ui';
import 'package:anime_list/Designs/Materials/Colors.dart';
import 'package:anime_list/Model/AnimeJsonModel.dart';
import 'package:anime_list/Model/UserDataModel.dart';
import 'package:anime_list/Services/AuthenticationService.dart';
import 'package:anime_list/Services/FirestoreDatabase.dart';
import 'package:anime_list/Widgets/imageDescribtion.dart';
import 'package:anime_list/Routes/Pages/FullView.dart';
import 'package:anime_list/Widgets/ElevatedGadientButton.dart';
import 'package:anime_list/Widgets/LoadingState.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ImageDetail extends StatefulWidget {
  final String image;
  final String imageSource;
  final dynamic animeNameEng;
  final dynamic animeNameJap;
  final String previewImage;
  final dynamic characterName;
  final dynamic tags;
  final VoidCallback onPressed;

  ImageDetail({
    required this.image,
    required this.imageSource,
    required this.animeNameEng,
    required this.animeNameJap,
    required this.previewImage,
    required this.tags,
    required this.characterName,
    required this.onPressed,
  });

  @override
  _ImageDetailState createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  late final Image image;

  late final Anime anime;

  late FToast fToast;

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  void viewFullImage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FullView(
              image: image,
            )));
  }

  void setAsProfile(Database database, LocalUser user) async {
    await database.updateUser(
        user.uid, 'UserData.displayImage', widget.previewImage);
  }

  @override
  void initState() {
    super.initState();
    image = Image.network(widget.image);
    anime = Anime(
        image: widget.image,
        previewImage: widget.previewImage,
        characterName: widget.characterName,
        animeNameJap: widget.animeNameJap,
        animeNameEng: widget.animeNameEng,
        imageSource: widget.imageSource,
        tags: widget.tags);
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image.image, context);
  }

  Future<bool> onLikeButtonTapped(
      {required bool isLiked,
      required Database database,
      required LocalUser user,
      required Anime animeImage}) async {
    if (isLiked == false) {
      database.updateFavourite(user.uid, 'UserData.favourites',
          FieldValue.arrayUnion([animeImage.toJson()]));
    } else {
      database.updateFavourite(user.uid, 'UserData.favourites',
          FieldValue.arrayRemove([animeImage.toJson()]));
    }

    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black54,
      ),
      child: Text(
        "Double click to view",
        style: GoogleFonts.comfortaa(
          color: Colors.white,
        ),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black26,
    ));
    final database = Provider.of<Database>(context);
    final user = Provider.of<LocalUser>(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/wallpaper/background/rin.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: SizedBox(
            child: DecoratedBox(
              decoration:
                  BoxDecoration(color: Color.fromRGBO(255, 255, 255, 15)),
              child: StreamBuilder<DocumentSnapshot<Object?>>(
                  stream: database.getUserDataAsStream(user.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final _data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      final data = userDataModelFromJson(_data);
                      return viewImage(context, data, database, user);
                    } else {
                      return Center(child: LoadingState.defaultGifLoading());
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }

  CachedNetworkImage viewImage(BuildContext context, UserDataModel snapshot,
      Database database, LocalUser user) {
    bool isLiked = false;
    snapshot.userData.favourites.forEach((element) {
      if (element.containsValue(anime.imageSource)) {
        isLiked = true;
      }
    });
    return CachedNetworkImage(
      imageUrl: widget.image,
      imageBuilder: (BuildContext context, ImageProvider<Object> provider) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Image(
                  image: provider,
                ),
                onDoubleTap: viewFullImage,
                onTap: _showToast,
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedGradientButton(
                          height: 35.h,
                          width: 120.w,
                          child: Text(
                            'Download',
                            style: TextStyle(
                                color: Color(0xFFE2E5E7),
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          radius: 10,
                          color: Color(0xFFFA4584),
                          onPressed: widget.onPressed,
                        ),
                        ElevatedGradientButton(
                            height: 35.h,
                            width: 120.w,
                            child: Text(
                              'Set as Profile',
                              style: TextStyle(
                                  color: Color(0xFFE2E5E7),
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            radius: 10,
                            color: Color(0xFFFA4584),
                            onPressed: () {
                              setAsProfile(database, user);
                            }),
                        LikeButton(
                          isLiked: isLiked,
                          likeBuilder: (isLiked) {
                            return isLiked
                                ? Icon(
                                    Icons.favorite,
                                    color: Color(0xFFFA4584),
                                    size: 34,
                                  )
                                : Icon(
                                    Icons.favorite_border_rounded,
                                    color: Colors.blueGrey,
                                    size: 34,
                                  );
                          },
                          circleColor: CircleColor(
                              start: Colors.white,
                              end: DefaultUIColors.appBarColor),
                          bubblesColor: BubblesColor(
                              dotPrimaryColor: DefaultUIColors.appBarColor,
                              dotSecondaryColor: Colors.white),
                          // onTap: onLikeButtonTapped,
                          onTap: (isLiked) async {
                            return onLikeButtonTapped(
                              isLiked: isLiked,
                              database: database,
                              user: user,
                              animeImage: anime,
                            );
                          },
                        ),
                      ],
                    ),
                    /////////////////////////////////////////
                    SizedBox(height: 20.h),
                    // image describtion
                    ImageDescribtion(
                      engName: widget.animeNameEng,
                      japName: widget.animeNameJap,
                      characters: widget.characterName,
                      tags: widget.tags,
                    ),
                    SizedBox(height: 20.h),
                    sourceImage(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      progressIndicatorBuilder: (_, String string, DownloadProgress progress) {
        if (progress.totalSize != null) {
          return Center(
            child: SizedBox(
              height: 110.h,
              width: 150.w,
              child: Column(
                children: [
                  LoadingState.defaultGifLoading(),
                  SizedBox(height: 10),
                  LinearPercentIndicator(
                    animation: true,
                    animateFromLastPercent: true,
                    curve: Curves.easeInOutQuad,
                    lineHeight: 5,
                    backgroundColor: Color(0xff0CCBAC),
                    linearGradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFfcd9d5),
                          Color(0xFFfcbbb3),
                        ]),
                    percent: progress.downloaded / progress.totalSize!,
                  ),
                ],
              ),
            ),
          );
        } else
          return Center();
      },
    );
  }

/////////////////////
  Align sourceImage() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(top: 10.r),
        child: ElevatedGradientButton(
          child: Text(
            'source',
            style: TextStyle(
              // color: Color(0xFF1B1B1B),
              color: Colors.black,
            ),
          ),
          height: 26,
          width: 78,
          radius: 6,
          gradient: LinearGradient(
              begin: Alignment(0.4, -1),
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF8693ab),
                Color(0xFFbdd4e7),
              ]),
          onPressed: () {
            _launchInBrowser(widget.imageSource);
          },
        ),
      ),
    );
  }
}
