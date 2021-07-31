import 'package:anime_list/Music/MusicPlayer.dart';
import 'package:anime_list/Services/AuthenticationService.dart';
import 'package:anime_list/Widgets/UITextField.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  late final AuthBase _authBase;

  TextEditingController nameTextController = TextEditingController();

  TextEditingController emailTextController = TextEditingController();

  TextEditingController passwordTextController = TextEditingController();

  FocusNode focusNode = FocusNode(canRequestFocus: true);

  bool isAlreadyUser = false;

  late Music _music;

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    _music = Music(audioPlayer: AudioPlayer());

    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((timeStamp) => _music.initAudio());
  }

  @override
  void didChangeDependencies() {
    _authBase = Provider.of<AuthBase>(context);
    super.didChangeDependencies();
  }

  void toggleBox() {
    setState(() {
      nameTextController.clear();
      emailTextController.clear();
      passwordTextController.clear();
      cardKey.currentState!.toggleCard();
    });
  }

  Future<void> register() async {
    if (nameTextController.text == '' ||
        emailTextController.text == '' ||
        passwordTextController.text == '') {
      print('invalid');
      return;
    }

    await _authBase.registerWithEmailPassword(
      email: emailTextController.text,
      password: passwordTextController.text,
      name: nameTextController.text,
    );
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
    nameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    _music.stopAudio();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(
                    'Exit?',
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
                        onPressed: () {
                          _music.stopAudio();
                          Navigator.pop<bool>(context, true);
                        },
                        child: Text(
                          'Yes',
                          style: GoogleFonts.comfortaa(),
                        )),
                  ],
                ))) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Stack(
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
              child: FlipCard(
                key: cardKey,
                flipOnTouch: false,
                direction: FlipDirection.HORIZONTAL,
                speed: 1000,
                front: formBox(
                  title: 'Register',
                  altText: 'already a user?',
                  altButtonText: 'Log in',
                  altButtonTextOnPressed: toggleBox,
                  onSubmitPressed: register,
                ),
                back: formBox(
                  title: 'Log in',
                  altText: 'Need an account?',
                  altButtonText: 'Register',
                  altButtonTextOnPressed: toggleBox,
                  onSubmitPressed: login,
                ),
                onFlipDone: (_) {
                  setState(() {
                    isAlreadyUser = !isAlreadyUser;
                  });
                },
              ),
            ),
            floatingActionButton: SizedBox(
              width: 170,
              child: FloatingActionButton(
                onPressed: () async {
                  await _authBase.signInAnonymously();
                },
                backgroundColor: Color.fromRGBO(0, 0, 0, 170),
                child: Text(
                  'Skip for now',
                  style: GoogleFonts.comfortaa(
                    fontSize: 17,
                    color: Colors.white70,
                  ),
                ),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                splashColor: Colors.white30,
              ),
            ),
          ),
        ],
      ),
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
            isAlreadyUser
                ? Center()
                : UITextField(
                    controller: nameTextController,
                    onSubmitted: (_) {
                      focusNode.requestFocus();
                    },
                    hintText: 'Name',
                    textInputAction: TextInputAction.next),
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
