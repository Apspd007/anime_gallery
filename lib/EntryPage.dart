import 'package:anime_list/Loginpage.dart';
import 'package:anime_list/Music/MusicPlayer.dart';
import 'package:anime_list/MyApp.dart';
import 'package:anime_list/Services/AuthenticationService.dart';
import 'package:anime_list/Model/AppSettingsConfig.dart';
import 'package:anime_list/Services/FirestoreDatabase.dart';
import 'package:anime_list/Video/VideoPlayer.dart';
import 'package:anime_list/Widgets/LoadingState.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  @override
  void initState() {
    super.initState();
    // checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    print("connectivityResult : $connectivityResult");
  }

  Widget build(BuildContext context) {
    final Database _database = MyFirestoreDatabse();
    // print(connectivityResult.toString());
    final _authBase = Provider.of<AuthBase>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<LocalUser?>(
        stream: _authBase.authStateChange(),
        builder:
            (BuildContext context, AsyncSnapshot<LocalUser?> userSnapshot) {
          if (userSnapshot.hasData) {
            if (userSnapshot.connectionState == ConnectionState.active) {
              if (userSnapshot.data == null) {
                return Center(child: Text('Snapshot has no data'));
              } else {
                return MultiProvider(
                  providers: [
                    Provider<LocalUser>(
                        create: (_) => LocalUser(
                            uid: userSnapshot.data!.uid,
                            displayName: userSnapshot.data!.displayName,
                            email: userSnapshot.data!.email,
                            isAnonymous: userSnapshot.data!.isAnonymous)),
                    Provider<AppSettingsConfig>(
                        create: (_) =>
                            AppSettingsConfig(isWifiConnected: false)),
                  ],
                  child: MyApp(),
                );
              }
            } else {
              return Center(child: LoadingState.defaultGifLoading());
            }
          } else if (userSnapshot.hasError) {
            return Center(
              child: Text(userSnapshot.error.toString()),
            );
          } else if (userSnapshot.hasData == false) {
            return Loginpage();
          } else {
            return Center(
              child: Text('Somthing else happened'),
            );
          }
        },
      ),
    );
  }
}
