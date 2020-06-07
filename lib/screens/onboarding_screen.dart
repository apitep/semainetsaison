import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../constants.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Get.offNamed('/home');
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 16.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
            title: "Bienvenue à bord !",
            body: "Cette application va aider votre enfant à apprendre les jours de la semaine, les mois et les saisons.",
            image: _buildImage('onboard/01'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Une série d'exercices",
            body: "Pour l'inciter à faire les exercices, il commence par choisir l'album animé qu'il pourra regardé quand il aura terminé.",
            image: _buildImage('onboard/02'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "L'école des loisirs",
            body:
                "Ces albums animés sont disponibles gràce à la formidable initiative de l'école des loisirs qui les mets librement à disposition de tous les enfants petits et grands.",
            image: _buildImage('onboard/03'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Another title page",
            body: "Another beautiful body text for this example onboarding",
            image: _buildImage('onboard/04'),
            footer: RaisedButton(
              onPressed: () {
                introKey.currentState?.animateScroll(0);
              },
              child: const Text(
                'FooButton',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Title of last page",
            bodyWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Click on ", style: bodyStyle),
                Icon(Icons.edit),
                Text(" to edit a post", style: bodyStyle),
              ],
            ),
            image: _buildImage('onboard/05'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text('Passer'),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Terminer', style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
