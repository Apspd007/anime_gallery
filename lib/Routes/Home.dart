import 'package:anime_list/Designs/Materials/Colors.dart';
import 'package:anime_list/Features/For_HomeScreen/AppbarButton.dart';
import 'package:anime_list/Model/AnimeJsonModel.dart';
import 'package:anime_list/Features/Listing/AnimesListing.dart';
import 'package:anime_list/Model/UserDataModel.dart';
import 'package:anime_list/Services/AuthenticationService.dart';
import 'package:anime_list/Services/FirestoreDatabase.dart';
import 'package:anime_list/Widgets/GetImage.dart';
import 'package:anime_list/Widgets/LoadingState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isRecentPressed = true;
  bool isRandomPressed = false;
  bool isFavPressed = false;
  int index = 0;
  bool refreshed = true;

  Widget changeSelection(int _index, Database _database, LocalUser _user) {
    switch (_index) {
      case 0:
        isRecentPressed = true;
        isRandomPressed = false;
        isFavPressed = false;
        return recentImages(_database, _user);
      case 1:
        isRecentPressed = false;
        isFavPressed = false;
        isRandomPressed = true;
        return randomImages(_database, _user);
      case 2:
        isRecentPressed = false;
        isFavPressed = true;
        isRandomPressed = false;
        return favouriteImages(_database, _user);
      default:
        isRecentPressed = true;
        isRandomPressed = false;
        isFavPressed = false;
        return recentImages(_database, _user);
    }
  }

  @override
  void initState() {
    // WidgetsBinding.instance!.addPostFrameCallback(
    //     (_) => MyRandomAnimeListing.getRandomList(_animeName));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // MyRandomAnimeListing.getRandomList(_animeName);
  }

  @override
  Widget build(BuildContext context) {
    Database _database = Provider.of<Database>(context);
    LocalUser user = Provider.of<LocalUser>(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: DefaultUIColors.appBarColor,
    ));
    // final padding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.only(top: 24.h),
        child: changeSelection(index, _database, user),
        // index == 0
        //     ? randomImages(_database, user)
        //     : favouriteImages(_database, user),
      ),
    );
  }

  FutureBuilder<DocumentSnapshot<Object?>> recentImages(
      Database _database, LocalUser user) {
    return FutureBuilder<DocumentSnapshot<Object?>>(
        future: _database.getAllImagesAsFuture(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> _data =
                  snapshot.data!.data() as Map<String, dynamic>;
              List<Anime> data = AnimeListing.getRecentList(_data);
              return CustomScrollView(slivers: [
                appBar(_database, user),
                imageGrid(context, data, user),
              ]);
            } else {
              return Center(child: LoadingState.defaultGifLoading());
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text((snapshot.error).toString()),
            );
          } else {
            return Center(child: LoadingState.defaultGifLoading());
          }
        });
  }

  FutureBuilder<DocumentSnapshot<Object?>> randomImages(
      Database _database, LocalUser user) {
    return FutureBuilder<DocumentSnapshot<Object?>>(
        future: _database.getAllImagesAsFuture(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> _data =
                  snapshot.data!.data() as Map<String, dynamic>;
              List<Anime> data = AnimeListing.getRandomList(_data);
              return CustomScrollView(slivers: [
                appBar(_database, user),
                imageGrid(context, data, user),
              ]);
            } else {
              return Center(child: LoadingState.defaultGifLoading());
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text((snapshot.error).toString()),
            );
          } else {
            return Center(child: LoadingState.defaultGifLoading());
          }
        });
  }

  StreamBuilder<DocumentSnapshot<Object?>> favouriteImages(
      Database _database, LocalUser user) {
    return StreamBuilder<DocumentSnapshot<Object?>>(
        stream: _database.getUserDataAsStream(user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.active) {
              Map<String, dynamic> _data =
                  snapshot.data!.data() as Map<String, dynamic>;
              UserDataModel dataModel = userDataModelFromJson(_data);
              List<Anime> data = AnimeListing.getFavouriteList(dataModel);
              return CustomScrollView(slivers: [
                appBar(_database, user),
                data.isEmpty
                    ? SliverToBoxAdapter(
                        child: Padding(
                        padding: EdgeInsets.only(top: 45.h),
                        child: Center(
                            child: Column(
                          children: [
                            LoadingState.fromAsset(
                                'assets/wallpaper/placeholder/nothing.gif'),
                          ],
                        )),
                      ))
                    : imageGrid(context, data, user),
              ]);
            } else {
              return Center(child: LoadingState.defaultGifLoading());
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text((snapshot.error).toString()),
            );
          } else {
            return Center(child: LoadingState.defaultGifLoading());
          }
        });
  }

  SliverAppBar appBar(Database _database, LocalUser user) {
    return SliverAppBar(
      floating: true,
      expandedHeight: 70.h,
      toolbarHeight: 50.h,
      backgroundColor: DefaultUIColors.appBarColor,
      actions: [
        TextButton(
            style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all<Color?>(Colors.black26)),
            onPressed: () {
              if (index == 0) return;
              setState(() {
                index = 0;
              });
              changeSelection(index, _database, user);
            },
            child: AppbarButton(isPressed: isRecentPressed, text: 'Recent')),
        TextButton(
            style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all<Color?>(Colors.black26)),
            onPressed: () {
              if (index == 1) return;
              setState(() {
                index = 1;
              });
              changeSelection(index, _database, user);
            },
            child: AppbarButton(isPressed: isRandomPressed, text: 'Random')),
        TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color?>(Colors.black26)),
          onPressed: () {
            if (index == 2) return;
            setState(() {
              index = 2;
            });
            changeSelection(index, _database, user);
          },
          child: AppbarButton(
            isPressed: isFavPressed,
            text: 'Favourite',
          ),
        ),
      ],
    );
  }

  SliverPadding imageGrid(
      BuildContext context, List<Anime> snapshot, LocalUser user) {
    return SliverPadding(
      padding: const EdgeInsets.all(10.0),
      sliver: SliverStaggeredGrid.countBuilder(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
          itemCount: snapshot.length,
          itemBuilder: (BuildContext context, int index) {
            return GetImage(
              animeNameEng: snapshot[index].animeNameEng,
              animeNameJap: snapshot[index].animeNameJap,
              characterName: snapshot[index].characterName,
              previewImage: snapshot[index].previewImage,
              image: snapshot[index].image,
              imageSource: snapshot[index].imageSource,
              tags: snapshot[index].tags,
            );
          }),
    );
  }
}
