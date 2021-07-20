import 'package:flutter/material.dart';

class LoadingState {
  LoadingState._();
  static Widget defaultGifLoading() {
    return Image.asset(
      'assets/wallpaper/placeholder/waiting.gif',
      scale: 5,
    );
  }

  static Widget fromAsset(String assetUrl) {
    return Image.asset(
      assetUrl,
      scale: 5,
    );
  }
}
