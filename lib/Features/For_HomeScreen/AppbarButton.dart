import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppbarButton extends StatelessWidget {
  final bool isPressed;
  final String text;
  AppbarButton({
    required this.isPressed,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: GoogleFonts.comfortaa(
        fontSize: 19,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        decoration:
            isPressed == true ? TextDecoration.underline : TextDecoration.none,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2,
        letterSpacing: 1,
      ),
    );
  }
}
