import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

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

    super.initState();
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
                  Text(
                    Constants.appName,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, fontFamily: 'MontserratAlternates', color: Colors.white),
                  ),
                ],
              ),
              delay: delayedAmount + 600,
            ),
            SizedBox(height: 15.0),
            DelayedAnimation(
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
              delay: delayedAmount + 200,
            ),
            SizedBox(height: 5.0),
            DelayedAnimation(
              child: Text(
                "Apprendre à petit pas",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w300, fontFamily: 'MontserratAlternates', color: Colors.white),
              ),
              delay: delayedAmount + 1350,
            ),
            SizedBox(height: 25.0),
            DelayedAnimation(
              delay: delayedAmount + 1600,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.17,
                    child: Center(
                      child: Text(
                      "avec les albums animés\noffert par l'école des loisirs",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, fontFamily: 'MontserratAlternates', color: Colors.white),
                    ),
                    ),
                  ),
                  Positioned(
                    right: 36,
                    bottom: 55,
                    child: Image.asset('assets/images/ecoleloisirslogo.png', height: 50),
                  ),

                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            SizedBox(height: 15.0),
            DelayedAnimation(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(title: Constants.appName),
                    ),
                  );
                },
                textColor: Colors.white,
                child: Text(
                  "Commencer",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, fontFamily: 'MontserratAlternates', color: Colors.white),
                ),
              ),
              delay: delayedAmount + 2400,
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
