import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopImagesFromDB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Top',
      maxLines: 1,
      style: GoogleFonts.comfortaa(
        fontSize: 19,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        decoration: TextDecoration.underline,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2,
        letterSpacing: 1,
      ),
    );
  }
}
