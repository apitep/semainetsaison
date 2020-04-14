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
      CircleAvatar(
        backgroundColor: Colors.grey[100],
        child: Image.asset(
          'assets/images/ApitepBearLogo.png',
          height: 28,
          color: Constants.kColorLightGreen,
        ),
        radius: 20,
      ),
      SizedBox(width: 10),
    ],
  );
}
