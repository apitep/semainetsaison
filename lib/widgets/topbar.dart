import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/sound_controller.dart';
import '../screens/exercices_screen.dart';

Widget topBar(context, title) {
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
      GetX<SoundController>(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Material(
              color: Colors.transparent, // button color
              child: InkWell(
                splashColor: Constants.kColorBgStart, // splash color
                onTap: () {
                  _.musicBackground(!_.isMusicPlaying.value);
                },
                child: Icon(_.isMusicPlaying.value ? Icons.pause_circle_filled : Icons.play_circle_filled, size: 42), // button pressed
              ),
            ),
          );
        },
      ),
    ],
  );
}
