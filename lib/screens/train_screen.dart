import 'dart:async';
import "dart:math";
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:confetti/confetti.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../constants.dart';
import '../widgets/topbar.dart';
import '../widgets/wordslider.dart';
import '../providers/app_provider.dart';
import '../models/events.dart';
import '../models/wagon_word.dart';
import '../models/story.dart';
import '../screens/seasons_screen.dart';

const kDays = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"];
const kMonths = ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"];

class TrainScreen extends StatefulWidget {
  TrainScreen({Key key, this.story}) : super(key: key);

  final Story story;

  @override
  _TrainScreenState createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen> with AfterLayoutMixin<TrainScreen> {
  ConfettiController _controllerCenter;
  AppProvider appProvider;
  List<WagonWord> daytrain, monthtrain;
  double nbSuccess = 0;
  double maxSuccess = 0;

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 1));
    daytrain = loadTrain(kDays, 4);
    monthtrain = loadTrain(kMonths, 4);
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    AssetsAudioPlayer.newPlayer().open(Audio("assets/sounds/trainvapeur.mp3"));
    eventBus.on<CheckResult>().listen((event) {
      _checkResults();
    });
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
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
    appProvider = Provider.of<AppProvider>(context);

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
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Le train des jours et des mois',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'MontserratAlternates',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 150,
                    child: WordSlider(words: daytrain),
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
                  SizedBox(height: 20),
                  Container(
                    height: 150,
                    child: WordSlider(words: monthtrain),
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
    nbSuccess = nbSuccess - 2;
    if (nbSuccess == daytrain.length + monthtrain.length - 2) _success();
  }

  _success() async {
    _controllerCenter.play();
    AssetsAudioPlayer.newPlayer().open(Audio("assets/sounds/levelup.mp3"));

    Timer(Duration(seconds: 6), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SeasonScreen(story: widget.story)));
    });
  }
}
