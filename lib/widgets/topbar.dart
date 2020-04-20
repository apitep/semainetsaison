import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/app_provider.dart';

Widget topBar(context, title) {
  AppProvider appProvider = Provider.of<AppProvider>(context);
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
        child: SizedBox.fromSize(
          size: Size(46, 46), // button width and height
          child: ClipOval(
            child: Material(
              color: Colors.orange, // button color
              child: InkWell(
                splashColor: Constants.kColorBgStart, // splash color
                onTap: () {
                  appProvider.musicBackground(!appProvider.isMusicPlaying);
                }, // button pressed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(appProvider.isMusicPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled), // icon// text
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
