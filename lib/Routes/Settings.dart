import 'package:anime_list/Model/UserDataModel.dart';
import 'package:anime_list/Services/AuthenticationService.dart';
import 'package:anime_list/Services/FirestoreDatabase.dart';
import 'package:anime_list/Widgets/LoadingState.dart';
import 'package:anime_list/Widgets/UITiles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authBase = Provider.of<AuthBase>(context);
    final _database = Provider.of<Database>(context);
    final user = Provider.of<LocalUser>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black38,
    ));
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<DocumentSnapshot<Object?>>(
          stream: _database.getUserDataAsStream(user.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final _data = snapshot.data!.data() as Map<String, dynamic>;
              final data = userDataModelFromJson(_data);
              return Padding(
                padding: EdgeInsets.only(bottom: 18.h, top: 32.3.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 250.h,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(27)),
                      ),
                      child: user.isAnonymous
                          ? anonymousUser(data)
                          : nonAnonymousUser(data),
                    ),
                    UITiles(text: '', onPressed: () {}),
                    UITiles(text: '', onPressed: () {}),
                    UITiles(text: 'Settings', onPressed: () {}),
                    UITiles(
                      text: 'About',
                      onPressed: () async {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: UITiles(
                        text: 'Sign Out',
                        onPressed: () async {
                          await Future.delayed(Duration(milliseconds: 300));
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text(
                                      'Sign Out?',
                                      style: GoogleFonts.comfortaa(),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop<bool>(context, false);
                                          },
                                          child: Text(
                                            'No',
                                            style: GoogleFonts.comfortaa(),
                                          )),
                                      TextButton(
                                          onPressed: () async {
                                            Navigator.pop<bool>(context, true);
                                            await _authBase.signOut(
                                                user.uid, user.isAnonymous);
                                          },
                                          child: Text(
                                            'Yes',
                                            style: GoogleFonts.comfortaa(),
                                          )),
                                    ],
                                  ));
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: LoadingState.defaultGifLoading(),
              );
            }
          }),
    );
  }

  Center anonymousUser(UserDataModel data) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(data.userData.displayImage),
            minRadius: 60.r,
            maxRadius: 67.r,
          ),
          Text(
            'You are Anonymous',
            style: GoogleFonts.comfortaa(
              fontSize: 20.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Center nonAnonymousUser(UserDataModel data) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(data.userData.displayImage),
            minRadius: 60.r,
            maxRadius: 67.r,
          ),
          Text(
            data.userData.displayName,
            style: GoogleFonts.comfortaa(
              fontSize: 20.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
