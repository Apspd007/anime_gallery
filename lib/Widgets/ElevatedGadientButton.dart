import 'package:flutter/material.dart';

class ElevatedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final Color? overlayColor;
  final Color color;
  final double width;
  final double height;
  final double radius;
  final VoidCallback onPressed;

  const ElevatedGradientButton({
    required this.child,
    this.gradient,
    this.overlayColor = Colors.cyan,
    this.color = Colors.lightBlue,
    this.radius = 5,
    required this.width,
    this.height = 50.0,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500]!,
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
        ],
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            overlayColor: MaterialStateProperty.all(overlayColor),
            borderRadius: BorderRadius.circular(radius),
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
