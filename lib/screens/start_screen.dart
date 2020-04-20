import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

import '../widgets/delayed_animation.dart';
import '../constants.dart';
import 'home_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key key}) : super(key: key);

  static const routeName = '/start';

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with SingleTickerProviderStateMixin {
  final int delayedAmount = 400;
  AnimationController controllerAnimation;
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    controllerAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });

    initPlayer();
    super.initState();
  }

  void initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kColorBgStart,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60.0,
            ),
            DelayedAnimation(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/ApitecLogo.png', height: 90),
                  Text(
                    "Apitep\nApprendre à petit pas",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, fontFamily: 'MontserratAlternates', color: Colors.white),
                  ),
                ],
              ),
              delay: delayedAmount + 600,
            ),
            SizedBox(height: 15.0),
            DelayedAnimation(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(title: Constants.appName),
                    ),
                  );
                },
                child: AvatarGlow(
                  endRadius: 100,
                  duration: Duration(seconds: 2),
                  glowColor: Colors.white24,
                  repeat: true,
                  repeatPauseDuration: Duration(seconds: 1),
                  startDelay: Duration(seconds: 1),
                  child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: Image.asset('assets/images/ApitepBearLogo.png', height: 90),
                        radius: 70.0,
                      )),
                ),
              ),
              delay: delayedAmount + 200,
            ),
            SizedBox(height: 5.0),
            DelayedAnimation(
              child: Text(
                Constants.appName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w600, fontFamily: 'MontserratAlternates', color: Colors.white),
              ),
              delay: delayedAmount + 1350,
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            SizedBox(height: 15.0),
            DelayedAnimation(
              delay: delayedAmount + 1600,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/ecoleloisirslogo.png', height: 70),
                  ),
                  Center(
                    child: Text(
                      "avec les albums animés\noffert par l'école des loisirs",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, fontFamily: 'MontserratAlternates', color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
