import 'package:flutter/material.dart';
import '../constants.dart';

Widget topBar(context, title) {
  String _title = title;

  return AppBar(
    backgroundColor: Constants.kColorBgStart,
    title: Text(
      _title,
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, fontFamily: 'MontserratAlternates'),
    ),
    actions: <Widget>[
      Image.asset(
        'assets/images/ApitepBearSmallLogo.png',
        height: 30,
        color: Constants.kColorLightGreen,
      ),
      SizedBox(width: 10),
    ],
  );
}
