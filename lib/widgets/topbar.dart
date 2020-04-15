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
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: () {},
          child: CircleAvatar(
            backgroundColor: Constants.kColorBgStart,
            child: Image.asset('assets/images/ApitepBearLogo.png', height: 37),
            radius: 30.0,
          ),
        ),
      ),
    ],
  );
}
