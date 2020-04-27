import 'dart:async';
import "dart:math";
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:confetti/confetti.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../../constants.dart';
import '../../widgets/topbar.dart';
import '../../widgets/train/train_slider.dart';
import '../../providers/app_provider.dart';
import '../../models/wagon_question.dart';
import '../../models/story.dart';
import '../fourseason_screen.dart';

const String kDescription = "Complète le petit train";

class TrainScreen extends StatefulWidget {
  TrainScreen({Key key, @required this.story, @required this.wagons}) : super(key: key);
  static const routeName = '/train';
  final Story story;
  final List<String> wagons;

  @override
  _TrainScreenState createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen> with AfterLayoutMixin<TrainScreen> {
  AppProvider appProvider;
  ConfettiController _confettiController;
  List<WagonQuestion> train;
  ValueNotifier<int> nbGoodAnswers = ValueNotifier<int>(0);
  int nbQuestions;

  @override
  void initState() {
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    train = loadTrain(widget.wagons, 3);
    nbQuestions = train.length - 1;
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
    _confettiController.dispose();
    super.dispose();
  }

  List<WagonQuestion> loadTrain(List<String> items, int nbItems) {
    var train = List<WagonQuestion>();
    var start = Random().nextInt(items.length - nbItems);
    var selectedItems = items.getRange(start, start + nbItems).toList();

    selectedItems.forEach((item) {
      if (train.length == 0) {
        train.add(WagonQuestion.loco(item));
      } else {
        train.add(WagonQuestion.wagon(item));
      }
    });

    return train;
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

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
                      'Complète le petit train',
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

    Timer(Duration(seconds: 6), () {
      if (widget.wagons == Constants.months) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FourSeasonScreen(story: widget.story)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TrainScreen(
              story: widget.story,
              wagons: Constants.months,
            ),
          ),
        );
      }
    });
  }
}
