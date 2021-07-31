import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final VoidCallback onPressed;
  TagButton({
    required this.text,
    this.backgroundColor,
    this.borderRadius = 20,
    this.elevation = 0,
    this.borderColor = Colors.black87,
    this.textColor = Colors.black87,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(elevation),
        side: MaterialStateProperty.all<BorderSide>(
            BorderSide(color: borderColor)),
        backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor == null ? Color(0xff5edfff) : backgroundColor!),
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius))),
      ),
      child: Text(
        text,
        style: GoogleFonts.comfortaa(
          // fontSize: 19,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
