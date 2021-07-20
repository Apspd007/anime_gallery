import 'package:anime_list/Services/AuthenticationService.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatelessWidget {
  final AuthBase _authBase = Auth();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('anonymously'),
        onPressed: () async {
          _authBase.signInAnonymously();
        },
      ),
    );
  }
}
