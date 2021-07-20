import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  TagButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
            BorderSide(color: Colors.black87)),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff5edfff)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
      child: Text(
        text,
        style: GoogleFonts.comfortaa(
          // fontSize: 19,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
