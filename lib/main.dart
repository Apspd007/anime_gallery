import 'dart:ui';
import 'package:anime_list/MainPages/EntryPage.dart';
import 'package:anime_list/Services/AuthenticationService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anime Wallpaper',
      home:
          // Gradiant
          Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF6BEE5),
                Color(0xFFD1FFFD),
              ]),
        ),
        child: ScreenUtilInit(
          designSize: Size(392.7, 816.7),
          builder: () => MultiProvider(
            providers: [
              Provider<AuthBase>(create: (_) => Auth()),
            ],
            child: EntryPage(),
          ),
        ),
      ),
      // Container(
      //   decoration: new BoxDecoration(
      //     image: new DecorationImage(
      //       image: new ExactAssetImage('assets/wallpaper/background/rin.png'),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      //   child: new BackdropFilter(
      //     filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      //     child: new Container(
      //       decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
      //       child: ScreenUtilInit(
      //     designSize: Size(392.7, 816.7),
      //     builder: () => MyApp(),
      //   ),
      //     ),
      //   ),
      // ),
    );
  }
}
