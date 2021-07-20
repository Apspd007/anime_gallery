import 'package:flutter/material.dart';

class ImageOPButton extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final double widthFactor;
  final AlignmentGeometry alignment;
  final Widget child;

  ImageOPButton({
    required this.child,
    required this.widthFactor,
    required this.alignment,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: padding,
        child: Align(
          alignment: alignment,
          child: SizedBox(
            height: 40,
            child: FractionallySizedBox(
              // width: 65,
              widthFactor: widthFactor,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
