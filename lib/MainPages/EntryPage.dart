import 'package:anime_list/MainPages/Loginpage.dart';
import 'package:anime_list/MainPages/MyApp.dart';
import 'package:anime_list/Services/AuthenticationService.dart';
import 'package:anime_list/Model/AppSettingsConfig.dart';
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
    // print(connectivityResult.toString());
    final _authBase = Provider.of<AuthBase>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<LocalUser?>(
        stream: _authBase.authStateChange(),
        builder: (BuildContext context, AsyncSnapshot<LocalUser?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data == null) {
                return Center(child: Text('Snapshot has no data'));
              } else {
                return MultiProvider(
                  providers: [
                    Provider<LocalUser>(
                        create: (_) => LocalUser(
                            uid: snapshot.data!.uid,
                            displayName: snapshot.data!.displayName,
                            email: snapshot.data!.email,
                            isAnonymous: snapshot.data!.isAnonymous)),
                    Provider<AppSettingsConfig>(
                        create: (_) =>
                            AppSettingsConfig(isWifiConnected: false))
                  ],
                  child: MyApp(),
                );
              }
            } else {
              return Center(child: LoadingState.defaultGifLoading());
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData == false) {
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
