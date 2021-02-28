import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldState> scaffholdKey = GlobalKey<ScaffoldState>();
double height;
double width;
Widget spacing(double byhight, double bywidth) {
  return new SizedBox(
    height: byhight != null || byhight > 0 ? height * byhight : 0,
    width: bywidth != null || bywidth > 0 ? width * bywidth : 0,
  );
}

TextStyle textStyle(Color color, double fontsize) {
  return TextStyle(
    color: color,
    fontSize: fontsize,
    fontWeight: FontWeight.bold,
    wordSpacing: 0.8,
    letterSpacing: 1.2,
  );
}
