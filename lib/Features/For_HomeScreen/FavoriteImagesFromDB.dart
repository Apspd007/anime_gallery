import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteImagesFromDB extends StatelessWidget {
  final bool isPressed;
  FavoriteImagesFromDB({
    required this.isPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      'Favorite',
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
