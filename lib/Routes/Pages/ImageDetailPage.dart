import 'dart:ui';
import 'package:anime_list/CustomWidgets/imageDescribtion.dart';
import 'package:anime_list/Routes/Pages/FullView.dart';
import 'package:anime_list/Services/DownloadFiles.dart';
import 'package:anime_list/Widgets/ElevatedGadientButton.dart';
import 'package:anime_list/Widgets/LoadingState.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ImageDetail extends StatefulWidget {
  final String fullImageUrl;
  final String imageDetailUrl;
  final String engAnimeName;
  final String japAnimeName;
  final dynamic chracter;
  final VoidCallback onPressed;

  ImageDetail({
    required this.fullImageUrl,
    required this.imageDetailUrl,
    required this.engAnimeName,
    required this.japAnimeName,
    required this.chracter,
    required this.onPressed,
  });

  @override
  _ImageDetailState createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  late final Image image;
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

  @override
  void initState() {
    super.initState();
    image = Image.network(widget.fullImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF6BEE5),
                  Color(0xFFD1FFFD),
                ]),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: viewImage(context),
          ),
        ),
      ],
    );
  }

  CachedNetworkImage viewImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.fullImageUrl,
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
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedGradientButton(
                    height: 35.h,
                    width: 140.w,
                    child: Text(
                      'Download',
                      style: TextStyle(
                          color: Color(0xFFE2E5E7),
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    radius: 10,
                    color: Color(0xFFfc6894),
                    onPressed: widget.onPressed,
                  ),
                  ElevatedGradientButton(
                      height: 35.h,
                      width: 140.w,
                      child: Text(
                        'View Image',
                        style: TextStyle(
                            color: Color(0xFFE2E5E7),
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      radius: 10,
                      color: Color(0xFFfc6894),
                      onPressed: viewFullImage),
                ],
              ),
              /////////////////////////////////////////
              SizedBox(height: 20.h),
              ImageDescribtion(
                engName: widget.engAnimeName,
                japName: widget.japAnimeName,
                tags: widget.chracter,
              ),
              SizedBox(height: 20.h),
              sourceImage(),
              SizedBox(height: 20.h),
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
                    backgroundColor: Colors.white,
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
            _launchInBrowser(widget.imageDetailUrl);
          },
        ),
      ),
    );
  }
}
