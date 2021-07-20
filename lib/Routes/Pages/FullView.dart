import 'package:flutter/material.dart';

class FullView extends StatelessWidget {
  final Image image;

  const FullView({required this.image});
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: image,
    );
  }
}
