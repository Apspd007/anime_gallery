import 'dart:ui';
import 'package:anime_list/Widgets/UIIcons.dart';
import 'package:anime_list/Designs/Materials/Colors.dart';
import 'package:anime_list/Routes/Categaries.dart';
import 'package:anime_list/Routes/Home.dart';
import 'package:anime_list/Routes/Settings.dart';
import 'package:anime_list/Routes/SearchImage.dart';
import 'package:anime_list/Routes/DownloadPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 2;
  @override
  Widget build(BuildContext context) {
    print('fMyApp, Size : ${MediaQuery.of(context).size}');
    // print('fMyApp, Padding : ${MediaQuery.of(context).padding}');
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(builder: (BuildContext context) {
        switch (index) {
          case 0:
            return Home();
          case 1:
            return Categories();
          case 2:
            return SearchImage();
          case 3:
            return DownloadPage();
          case 4:
            return SettingsPage();
          default:
            return Home();
        }
      }),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

// bottomNavigationBar
  Container bottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: DefaultUIColors.bottomNavigationBarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset.zero,
            blurRadius: 15,
          ),
        ],
      ),
      height: 70.h,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: UIIcons(
                icon: 'assets/home.png',
                label: 'Home',
                isPressed: index == 0 ? true : false,
              ),
              onTap: () {
                setState(() {
                  index = 0;
                });
              },
            ),
            GestureDetector(
              child: UIIcons(
                icon: 'assets/home.png',
                label: 'Categories',
                isPressed: index == 1 ? true : false,
              ),
              onTap: () {
                setState(() {
                  index = 1;
                });
              },
            ),
            GestureDetector(
              child: UIIcons(
                icon: 'assets/home.png',
                label: 'Search',
                isPressed: index == 2 ? true : false,
              ),
              onTap: () {
                setState(() {
                  index = 2;
                });
              },
            ),
            GestureDetector(
              child: UIIcons(
                icon: 'assets/home.png',
                label: 'Downloads',
                isPressed: index == 3 ? true : false,
              ),
              onTap: () {
                setState(() {
                  index = 3;
                });
              },
            ),
            GestureDetector(
              child: UIIcons(
                icon: 'assets/home.png',
                label: 'Setings',
                isPressed: index == 4 ? true : false,
              ),
              onTap: () {
                setState(() {
                  index = 4;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
