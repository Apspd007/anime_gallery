import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DownloadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Text('DownloadPage'),
        ));
  }
}
