import 'package:anime_list/Services/AuthenticationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authBase = Provider.of<AuthBase>(context);
    final user = Provider.of<LocalUser>(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ElevatedButton(
          child: Text('logout'),
          onPressed: () async {
            await _authBase.signOut(user.uid, user.isAnonymous);
          },
        ),
      ),
    );
  }
}
