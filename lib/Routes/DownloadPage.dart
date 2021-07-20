import 'package:anime_list/Services/FirestoreDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DownloadPage extends StatelessWidget {
  Database database = MyFirestoreDatabse();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: TextButton(
            child: Text('DownloadPage'),
            onPressed: () {
              database.getAnimes();
            },
          ),
        ));
  }
}
