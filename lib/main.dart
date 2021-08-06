import 'dart:ui';
import 'package:anime_list/Loginpage.dart';
import 'package:anime_list/Model/UserDataModel.dart';
import 'package:anime_list/MyApp.dart';
import 'package:anime_list/Services/AuthenticationService.dart';
import 'package:anime_list/Services/FirestoreDatabase.dart';
import 'package:anime_list/Video/VideoPlayer.dart';
import 'package:anime_list/Widgets/LoadingState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final AuthBase _authBase = Auth();
  final Database _database = MyFirestoreDatabse();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocalUser?>(
      stream: _authBase.authStateChange(),
      builder: (BuildContext context, AsyncSnapshot<LocalUser?> authSnapshot) {
        if (authSnapshot.hasData) {
          if (authSnapshot.connectionState == ConnectionState.active) {
            return FutureBuilder<DocumentSnapshot<Object?>>(
                future: _database.getUserDataAsFuture(authSnapshot.data!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final _data = snapshot.data!.data() as Map<String, dynamic>;
                    final userDataModel = userDataModelFromJson(_data);
                    return MultiProvider(
                      providers: [
                        Provider<AuthBase>(create: (_) => Auth()),
                        Provider<LocalUser>(
                            create: (_) => LocalUser(
                                uid: authSnapshot.data!.uid,
                                displayName: userDataModel.userData.displayName,
                                displayImage:
                                    userDataModel.userData.displayImage,
                                email: authSnapshot.data!.email,
                                emailVerified: authSnapshot.data!.emailVerified,
                                isAnonymous: authSnapshot.data!.isAnonymous)),
                        Provider<Database>(create: (_) => MyFirestoreDatabse()),
                      ],
                      child: MaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: 'Anime Wallpaper',
                        home: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/wallpaper/background/rin.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
                            child: ScreenUtilInit(
                              designSize: Size(392.7, 816.7),
                              builder: () => MyApp(),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Anime Wallpaper',
                      home: Container(
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
                          builder: () => LoadingState.defaultGifLoading(),
                        ),
                      ),
                    );
                  }
                });
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Anime Wallpaper',
              home: Container(
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
                  builder: () => LoadingState.defaultGifLoading(),
                ),
              ),
            );
          }
        } else {
          return MultiProvider(
            providers: [
              Provider<AuthBase>(create: (_) => Auth()),
              Provider<Database>(create: (_) => MyFirestoreDatabse()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Anime Gallery',
              home: Container(
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
                  // builder: () => Loginpage(),
                  builder: () => Loginpage(),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
