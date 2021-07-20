import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RandomImageFromDB extends StatelessWidget {
  final bool isPressed;
  RandomImageFromDB({
    required this.isPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      'Random',
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
