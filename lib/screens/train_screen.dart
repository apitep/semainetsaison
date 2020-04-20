import 'dart:async';
import "dart:math";
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:after_layout/after_layout.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:semainetsaison/constants.dart';

import '../widgets/topbar.dart';
import '../widgets/wordslider.dart';
import '../screens/videoplayer_screen.dart';
import '../models/wagon_word.dart';
import '../models/story.dart';

const kDays = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"];
const kMonths = ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"];

class TrainScreen extends StatefulWidget {
  TrainScreen({Key key, this.story}) : super(key: key);

  final Story story;

  @override
  _TrainScreenState createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen> with AfterLayoutMixin<TrainScreen> {
  PageController pageController;
  ConfettiController _controllerCenter;
  AudioPlayer audioSound;
  AudioPlayer audioBackground;
  List<WagonWord> daytrain, monthtrain;
  double nbSuccess = 0;

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 1));
    initPlayer();
    daytrain = loadTrain(kDays, 4);
    monthtrain = loadTrain(kMonths, 4);
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    audioSound.play('sounds/trainvapeur.mp3');
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  void initPlayer() {
    audioSound = AudioPlayer();
    audioBackground = AudioPlayer();
    audioBackground.setReleaseMode(ReleaseMode.LOOP);
  }

  List<WagonWord> loadTrain(List<String> items, int nbItems) {
    var train = List<WagonWord>();
    var start = Random().nextInt(items.length - nbItems);
    var selectedItems = items.getRange(start, start + nbItems).toList();

    selectedItems.forEach((item) {
      if (train.length == 0) {
        train.add(WagonWord.loco(item));
      } else {
        train.add(WagonWord.wagon(item));
      }
    });

    return train;
  }

  @override
  Widget build(BuildContext context) {
    _checkResults();

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
          appBar: topBar(context, Constants.kTitle),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Le train des jours et des mois',
                      style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'MontserratAlternates',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  RatingBar(
                    initialRating: nbSuccess,
                    minRating: nbSuccess,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 6,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 170,
                        child: WordSlider(words: daytrain),
                      ),
                    ],
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Container(
                        height: 170,
                        child: WordSlider(words: monthtrain),
                      ),
                    ],
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _checkResults() {
    nbSuccess = 0;
    for (var item in daytrain) {
      if (item.answer == item.guessingWord) nbSuccess++;
    }
    for (var item in monthtrain) {
      if (item.answer == item.guessingWord) nbSuccess++;
    }
    setState(() {
      nbSuccess = nbSuccess - 2;
      if (nbSuccess == daytrain.length + monthtrain.length - 2) _success();
    });
  }

  _success() async {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    _controllerCenter.play();
    audioSound.play(Constants.kUrlSoundSuccess);
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
