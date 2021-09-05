import 'package:flutter/material.dart';

/// getLogoWidget is the function that will format some image and will return
/// a Widget to it;
Widget getLogoWidget({ImageProvider? img}) {
  return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.fill,
              image: img ?? NetworkImage("https://i.imgur.com/BoN9kdC.png"))));
}
