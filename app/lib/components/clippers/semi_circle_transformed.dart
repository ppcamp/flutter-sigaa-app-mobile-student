import 'package:flutter/material.dart';

///
/// See https://medium.com/@mg55851/flutter-clippers-1fa3666f2bef
/// See also https://www.youtube.com/watch?v=eI43jkQkrvs&ab_channel=GoogleDevelopers
class SemiCircleTransformedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();

    // draw
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);

    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
