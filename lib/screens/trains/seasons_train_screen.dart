import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:after_layout/after_layout.dart';
import 'package:confetti/confetti.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/topbar.dart';
import '../../widgets/train/train_slider.dart';
import '../../screens/videoplayer_screen.dart';
import '../../providers/app_provider.dart';
import '../../models/events.dart';
import '../../models/wagon_question.dart';
import '../../models/story.dart';

const List<List<String>> kSeasons = [
  ["hiver", "décembre", "janvier", "février"],
  ["printemps", "mars", "avril", "mai"],
  ["été", "juin", "juillet", "août"],
  ["automne", "septembre", "octobre", "novembre"],
];

const String kDescription = "Complète le petit train avec les mois de l'année qui correspondent à la saison";

class SeasonTrainScreen extends StatefulWidget {
  SeasonTrainScreen({Key key, this.story}) : super(key: key);
  static const routeName = '/season';
  final Story story;

  @override
  _SeasonTrainScreenState createState() => _SeasonTrainScreenState();
}

class _SeasonTrainScreenState extends State<SeasonTrainScreen> with AfterLayoutMixin<SeasonTrainScreen> {
  AppProvider appProvider;
  ConfettiController _controllerCenter;
  List<WagonQuestion> train = List<WagonQuestion>();

  ValueNotifier<int> nbGoodAnswers = ValueNotifier<int>(0);
  int nbQuestions = 0;

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 1));
    var selectedSeason = kSeasons[Random().nextInt(kSeasons.length)];
    nbQuestions = selectedSeason.length - 1;
    train = loadTrain(selectedSeason);

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
    eventBus.fire(MusicBackground(false));
    super.dispose();
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
              child: Container(
                height: 130,
                child: TrainSlider(
                  wagons: train,
                  nbSuccess: nbGoodAnswers,
                ),
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

  List<WagonQuestion> loadTrain(List<String> items) {
    return items.map((item) => WagonQuestion.wagon(item)).toList()..first.loco = true;
  }

  _success() async {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    _controllerCenter.play();
    AssetsAudioPlayer.newPlayer().open(Audio(Constants.kSoundLevelUp));
    await widget.story.getStreamingUrls();

    Timer(Duration(seconds: 6), () {
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
