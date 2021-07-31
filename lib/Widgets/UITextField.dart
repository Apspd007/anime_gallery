import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UITextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final String hintText;
  final Function(String)? onSubmitted;
  UITextField({
    required this.controller,
    required this.onSubmitted,
    required this.hintText,
    required this.textInputAction,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      autofocus: false,
      autocorrect: false,
      cursorColor: Colors.white70,
      cursorRadius: Radius.circular(5),
      style: GoogleFonts.comfortaa(
        color: Colors.white70,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        alignLabelWithHint: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white60),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(1.2),
          borderSide: BorderSide(
            color: Colors.white70,
            width: 4.0,
          ),
        ),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
      ),
      textInputAction: textInputAction,
      controller: controller,
      onSubmitted: onSubmitted,
    );
  }
}
