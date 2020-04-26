import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/events.dart';
import '../providers/app_provider.dart';
import '../screens/exercices_screen.dart';

Widget topBar(context, title) {
  AppProvider appProvider = Provider.of<AppProvider>(context);
  String _title = title;

  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Constants.kColorBgStart,
    leading: Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ExercicesScreen()));
        },
        child: CircleAvatar(
          backgroundColor: Constants.kColorBgStart,
          child: Image.asset('assets/images/ApitepBearLogo.png', height: 37),
          radius: 30.0,
        ),
      ),
    ),
    title: Text(
      _title,
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, fontFamily: 'MontserratAlternates'),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Material(
          color: Colors.transparent, // button color
          child: InkWell(
            splashColor: Constants.kColorBgStart, // splash color
            onTap: () {
              eventBus.fire(MusicBackground(!appProvider.isMusicPlaying));
            },
            child: Icon(appProvider.isMusicPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled, size: 42), // button pressed
          ),
        ),
      ),
    ],
  );
}
