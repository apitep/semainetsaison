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
import '../models/wagon_word.dart';
import '../models/story.dart';
import '../screens/seasons_screen.dart';

const kDays = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"];
const kMonths = ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"];
const String kDescription = "Complète le train des jours de la semaine, et aussi celui des mois de l'année.";

class TrainScreen extends StatefulWidget {
  TrainScreen({Key key, this.story}) : super(key: key);
  static const routeName = '/train';
  final Story story;

  @override
  _TrainScreenState createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen> with AfterLayoutMixin<TrainScreen> {

  AppProvider appProvider;
  ConfettiController _controllerCenter;
  List<WagonWord> daytrain, monthtrain;
  ValueNotifier<int> nbGoodAnswers = ValueNotifier<int>(0);
  int nbQuestions;

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 1));
    daytrain = loadTrain(kDays, 3);
    monthtrain = loadTrain(kMonths, 3);
    nbQuestions = daytrain.length + monthtrain.length - 2;
    nbGoodAnswers.addListener(() {
      if (nbGoodAnswers.value == nbQuestions) _success();
    });
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    AssetsAudioPlayer.newPlayer().open(Audio(Constants.kSoundTrainVapeur));
    Timer(Duration(seconds: 6), () {
      appProvider.speak(kDescription);
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
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.white.withOpacity(.7),
          appBar: topBar(context, Constants.kTitle),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 150,
                    child: WordSlider(words: daytrain, nbSuccess: nbGoodAnswers),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Complète le train des jours',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'MontserratAlternates',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 150,
                    child: WordSlider(words: monthtrain, nbSuccess: nbGoodAnswers),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Complète le train des mois',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'MontserratAlternates',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                setState(() {
                  appProvider.speak(kDescription);
                });
              },
              child: Icon(Icons.volume_up, size: 34),
            ),
          ),
        ),
      ],
    );
  }

  _success() async {
    _controllerCenter.play();
    AssetsAudioPlayer.newPlayer().open(Audio(Constants.kSoundLevelUp));

    Timer(Duration(seconds: 6), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SeasonScreen(story: widget.story)));
    });
  }
}
