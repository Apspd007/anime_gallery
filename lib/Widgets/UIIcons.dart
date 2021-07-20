import 'package:anime_list/Designs/Materials/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UIIcons extends StatelessWidget {
  final String icon;
  final String label;
  final bool isPressed;

  UIIcons({required this.icon, required this.label, required this.isPressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 55.h,
      width: 70.h,
      duration: Duration(milliseconds: 230),
      decoration: BoxDecoration(
        color: DefaultUIColors.bottomNavigationBarColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: isPressed
            ? [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset.zero,
                  blurRadius: 4.r,
                ),
              ]
            : [],
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(2.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                icon,
                color: Colors.white,
              ),
              Text(
                label,
                style: GoogleFonts.comfortaa(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
