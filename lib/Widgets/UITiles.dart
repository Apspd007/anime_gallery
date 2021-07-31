import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UITiles extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  UITiles({
    required this.text,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        child: Ink(
          width: double.infinity,
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: GoogleFonts.comfortaa(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(5),
        highlightColor: Colors.transparent,
        overlayColor: MaterialStateProperty.all<Color>(Colors.white24),
        splashFactory: InkSplash.splashFactory,
        onTap: onPressed,
      ),
    );
  }
}
