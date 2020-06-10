import 'dart:async';
import "dart:math";
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:confetti/confetti.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../constants.dart';
import '../widgets/topbar.dart';
import '../widgets/train/train_slider.dart';
import '../controllers/app_controller.dart';
import '../controllers/sound_controller.dart';
import '../models/wagon_question.dart';
import '../models/story.dart';
import '../screens/fourseason_screen.dart';

class TrainScreen extends StatefulWidget {
  TrainScreen({Key key, @required this.story, @required this.wagons, @required this.exerciceDescription, @required this.nbWagons}) : super(key: key);
  static const routeName = '/train';
  final Story story;
  final List<String> wagons;
  final String exerciceDescription;
  final int nbWagons;

  @override
  _TrainScreenState createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen> {
  SoundController soundController = AppController.to.soundController;

  ConfettiController _confettiController;
  List<WagonQuestion> train;
  ValueNotifier<int> nbGoodAnswers = ValueNotifier<int>(0);
  int nbQuestions;

  @override
  void initState() {
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    train = loadTrain(widget.wagons, widget.nbWagons);
    nbQuestions = train.length - 1;
    nbGoodAnswers.addListener(() {
      if (nbGoodAnswers.value == nbQuestions) _success();
    });
    AssetsAudioPlayer.newPlayer().open(Audio(Constants.kSoundTrainVapeur));
    Timer(Duration(seconds: 6), () {
      soundController.speak(widget.exerciceDescription);
    });
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  List<WagonQuestion> loadTrain(List<String> items, int nbItems) {
    var train = List<WagonQuestion>();
    var selectedItems = List<String>();
    int start;

    if (nbItems < items.length) {
      //start = Random().nextInt(items.length - nbItems);
      start = pick(0, items.length - nbItems);
      selectedItems = items.getRange(start, start + nbItems).toList();
    } else {
      start = pick(0, items.length);
      selectedItems = items.getRange(0, nbItems).toList();
    }

    selectedItems.forEach((item) {
      if (train.length == 0) {
        train.add(WagonQuestion.loco(item));
      } else {
        train.add(WagonQuestion.wagon(item));
      }
    });

    return train;
  }

  int pick(int a, int b) => a + Random().nextInt(b - a + 1);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.story.thumbUrl),
              fit: BoxFit.cover,
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
                    child: TrainSlider(wagons: train, nbSuccess: nbGoodAnswers),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.exerciceDescription,
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
                  soundController.speak(widget.exerciceDescription);
                });
              },
              child: Icon(Icons.volume_up, size: 34),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.8,
            minimumSize: const Size(10, 10),
            maximumSize: const Size(50, 50),
            numberOfParticles: 3,
            gravity: 0.5,
            shouldLoop: false,
            colors: [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
          ),
        ),
      ],
    );
  }

  _success() async {
    _confettiController.play();
    AssetsAudioPlayer.newPlayer().open(Audio(Constants.kSoundLevelUp));

    Timer(Duration(seconds: 5), () {
      if (widget.wagons == Constants.days) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TrainScreen(
              story: widget.story,
              wagons: Constants.months,
              nbWagons: 3,
              exerciceDescription: "complète le petit train avec les mois de l'année",
            ),
          ),
        );
        return;
      }

      if (widget.wagons == Constants.months) {
        int selected = pick(0, Constants.kSeasons.length);
        List<String> season = Constants.kSeasons[selected];
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TrainScreen(
              story: widget.story,
              wagons: season,
              nbWagons: 4,
              exerciceDescription: "complète le petit train avec les mois qui correspondent à la saison",
            ),
          ),
        );
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FourSeasonScreen(story: widget.story)),
      );
    });
  }
}
