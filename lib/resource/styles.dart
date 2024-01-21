import 'package:flutter/material.dart';

abstract class Styles {
  static const buttonTextStyle = TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
  static const titleTextStyle = TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);

  static const snackBarTextStyle = TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  static const cafeTitleTextStyle = TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
  static const cafeSubtitleTextStyle = TextStyle(color: Colors.black, fontSize: 16);

  static const orderTitleTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const orderSubtitleTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  static const orderTrailingTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  static const drawerTitleTextStyle = TextStyle(color: Colors.brown, fontSize: 18, fontWeight: FontWeight.bold);
  static const drawerHeaderTextStyle = TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);
}
