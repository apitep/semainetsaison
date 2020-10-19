import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../controllers/app_controller.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    AppController.to.setDisplayOnBoard(false);
    super.initState();
  }

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
    const bodyStyle = TextStyle(fontSize: 16.0, color: Colors.white);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Color(0xFF264467),
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
            title: 'Bienvenue à bord !',
            body: 'Cette application va aider votre enfant à apprendre les jours de la semaine, les mois et les saisons.',
            image: _buildImage('onboard/01'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Une série d'exercices",
            body: "Pour l'inciter à faire les exercices,\nil commence par choisir l'album animé qu'il pourra regarder\nquand il aura terminé.",
            image: _buildImage('onboard/02'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: 'Dans le bon ordre',
            body:
                "Pour réussir cet exercice il faudra glisser les jours de la semaine dans le bon ordre. Dans l'exercice suivant ce sont les douze mois de l'année qu'il faudra glisser dans le bon ordre.",
            image: _buildImage('onboard/03'),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700, color: Colors.white),
              bodyTextStyle: TextStyle(fontSize: 15.0, color: Colors.white),
              descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              pageColor: Color(0xFF264467),
              imagePadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
            ),
          ),
          PageViewModel(
            title: 'Le petit train',
            body: "Et voici la série d'exercices\nla plus difficile !\nDans chaque wagonnet, il faudra écrire correctement à l'aide du clavier, le nom du jour de la semaine ou celui du mois de l'année.",
            image: _buildImage('onboard/04'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: 'Les 4 saisons',
            body: "Et enfin le dernier exercice\navant l'album animé !\n\nIci il faudra glisser chaque mois sur la saison qui correspond.",
            image: _buildImage('onboard/05'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: 'Merci !',
            body:
                "Ces albums animés sont disponibles gràce à la formidable initiative de l'école des loisirs, qui les mets librement à disposition de tous,\npetits et grands.",
            image: _buildImage('onboard/logo_edl_50ans'),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700, color: Colors.black),
              bodyTextStyle: TextStyle(fontSize: 15.0, color: Colors.black),
              descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              pageColor: Colors.white,
              imagePadding: EdgeInsets.zero,
            ),
          ),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text('Passer', style: TextStyle(color: Colors.white70)),
        next: const Icon(Icons.arrow_forward, color: Colors.white70),
        done: const Text('Jouer', style: TextStyle(fontWeight: FontWeight.w600)),
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
