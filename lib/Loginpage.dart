import 'dart:ffi';

import 'package:anime_list/Services/AuthenticationService.dart';
import 'package:anime_list/Widgets/UITextField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final AuthBase _authBase = Auth();

  TextEditingController emailTextController = TextEditingController();

  TextEditingController passwordTextController = TextEditingController();

  FocusNode focusNode = FocusNode(canRequestFocus: true);

  bool isAlreadyUser = false;

  void toggleBox() {
    setState(() {
      emailTextController.clear();
      passwordTextController.clear();
      isAlreadyUser = !isAlreadyUser;
    });
  }

  Future<void> register() async {
    if (emailTextController.text == '' || passwordTextController.text == '') {
      print('invalid');
      return;
    }

    await _authBase.registerWithEmailPassword(
        email: emailTextController.text, password: passwordTextController.text);
  }

  Future<void> login() async {
    if (emailTextController.text == '' || passwordTextController.text == '') {
      print('invalid');
      return;
    }
    await _authBase.signInWithEmailPassword(
        email: emailTextController.text, password: passwordTextController.text);
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            'assets/AMV_Slow_Motion.gif',
            fit: BoxFit.cover,
            color: Color.fromRGBO(0, 0, 0, 160),
            colorBlendMode: BlendMode.darken,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: isAlreadyUser
                ? formBox(
                    title: 'Log in',
                    altText: 'Need an account?',
                    altButtonText: 'Register',
                    altButtonTextOnPressed: toggleBox,
                    onSubmitPressed: login,
                  )
                : formBox(
                    title: 'Register',
                    altText: 'already a user?',
                    altButtonText: 'Log in',
                    altButtonTextOnPressed: toggleBox,
                    onSubmitPressed: register,
                  ),
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {}),
        ),
      ],
    );
  }

  Container formBox({
    required String title,
    required String altText,
    required String altButtonText,
    required VoidCallback altButtonTextOnPressed,
    required VoidCallback onSubmitPressed,
  }) {
    return Container(
      width: 330,
      height: 400,
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 170),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: GoogleFonts.comfortaa(
                color: Colors.white70,
                fontSize: 28,
                decoration: TextDecoration.underline,
              ),
            ),
            UITextField(
                controller: emailTextController,
                onSubmitted: (_) {
                  focusNode.requestFocus();
                },
                hintText: 'Email',
                textInputAction: TextInputAction.next),
            UITextField(
                controller: passwordTextController,
                onSubmitted: (_) {},
                hintText: 'Password',
                textInputAction: TextInputAction.done),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 10)),
                  side: MaterialStateProperty.all<BorderSide>(BorderSide(
                    color: Colors.white,
                  )),
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.white30),
                ),
                onPressed: onSubmitPressed,
                child: Text(
                  title,
                  style: GoogleFonts.comfortaa(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    altText,
                    style: GoogleFonts.comfortaa(
                      color: Colors.white70,
                    ),
                  ),
                  TextButton(
                    onPressed: altButtonTextOnPressed,
                    child: Text(
                      altButtonText,
                      style: GoogleFonts.comfortaa(
                        color: Colors.red[200],
                      ),
                    ),
                    style: ButtonStyle(splashFactory: NoSplash.splashFactory),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
