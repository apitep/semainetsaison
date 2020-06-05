import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:avatar_glow/avatar_glow.dart';

import '../constants.dart';
import '../controllers/app_controller.dart';
import '../widgets/delayed_animation.dart';
import 'home_screen.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({Key key}) : super(key: key);

  static const routeName = '/start';

  @override
  _StartupScreenState createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> with SingleTickerProviderStateMixin {
  final int delayedAmount = 400;
  AnimationController controllerAnimation;

  @override
  void initState() {
    controllerAnimation = AnimationController(vsync: this, duration: Duration(milliseconds: 200), lowerBound: 0.0, upperBound: 0.1)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Constants.kColorBgStart,
      body: GetBuilder<AppController>(
        init: AppController(),
        initState: (_) {
          AppController.to.init();
        },
        builder: (_) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 60.0,
                ),
                DelayedAnimation(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/images/ApitecLogo.png', height: 40),
                      Text(
                        "Apprendre à petit pas",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(title: Constants.appName)));
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
          );
        },
      ),
    );
  }
}
