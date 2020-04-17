import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:after_layout/after_layout.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

import '../widgets/topbar.dart';
import '../widgets/wordcard.dart';
import '../screens/videoplayer_screen.dart';
import '../models/wagon_word.dart';
import '../models/story.dart';

const kDays = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"];
const kMonths = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];

class TrainScreen extends StatefulWidget {
  TrainScreen({Key key, this.story}) : super(key: key);

  final Story story;

  @override
  _TrainScreenState createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen> with AfterLayoutMixin<TrainScreen> {
  PageController pageController;
  ConfettiController _controllerCenter;
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  List<WagonWord> daytrain = [WagonWord.loco('mercredi'), WagonWord.wagon('jeudi'), WagonWord.wagon('vendredi')];
  List<WagonWord> monthtrain = [WagonWord.loco('septembre'), WagonWord.wagon('octobre'), WagonWord.wagon('novembre')];

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 1));
    initPlayer();
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  void initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ConfettiWidget(
          confettiController: _controllerCenter,
          blastDirection: 0, // radial value - RIGHT
          emissionFrequency: 0.6,
          minimumSize: const Size(10, 10),
          maximumSize: const Size(50, 50),
          numberOfParticles: 1,
          gravity: 0.1, // don't specify a direction, blast randomly
          shouldLoop: false, // start again as soon as the animation is finished
          colors: [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.story.thumbUrl),
                colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.35), BlendMode.dstATop),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: topBar(context, "Le train des mots"),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Complète le train des jours',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'MontserratAlternates',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  child: PageView.builder(
                    controller: this.pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: daytrain.length,
                    itemBuilder: (ctx, index) {
                      final word = daytrain[index];
                      return WordCard(word);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Complète le train des mois',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'MontserratAlternates',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  child: PageView.builder(
                    controller: this.pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: monthtrain.length,
                    itemBuilder: (ctx, index) {
                      final word = monthtrain[index];
                      return WordCard(word);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _handleOnChanged(String value) {
    setState(() {});
  }

  _success() async {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    _controllerCenter.play();
    audioCache.play('sounds/applause.mp3');
    await widget.story.getStreamingUrls();

    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => VideoPlayerScreen(
            title: widget.story.title,
            url: widget.story.videoUrl,
            parentIsPortrait: isPortrait,
          ),
        ),
      );
    });
  }
}
