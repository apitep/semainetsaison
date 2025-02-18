import 'dart:async';
import 'package:flutter/material.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:semainetsaison/screens/vimeo_iframe_screen.dart';

import '../constants.dart';
import '../controllers/app_controller.dart';
import '../models/story.dart';
import '../widgets/season/draggable_month.dart';
import '../widgets/season/target_month.dart';
import '../widgets/topbar.dart';

const String kDescription = "Place dans l'ordre les mois de l'année correspondant à chaque saison";

class FourSeasonScreen extends StatefulWidget {
  FourSeasonScreen({Key key, this.story}) : super(key: key);
  static const routeName = '/fourseason';
  @override
  final Key key = UniqueKey();

  final Story story;

  @override
  _FourSeasonScreenState createState() => _FourSeasonScreenState();
}

class _FourSeasonScreenState extends State<FourSeasonScreen> {
  ConfettiController _confettiController;

  ValueNotifier<int> nbGoodAnswers = ValueNotifier<int>(0);
  int nbQuestions = 12;
  Color targetColor = Colors.white.withOpacity(0.1);
  Color overTargetColor = Colors.green.withOpacity(0.8);
  int dragMonthIndex = 0;

  @override
  void initState() {
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    nbGoodAnswers.addListener(() {
      if (nbGoodAnswers.value == nbQuestions) _success();
    });

    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kColorBgStart,
      appBar: topBar(context, Constants.kTitle),
      body: OrientationBuilder(builder: (context, orientation) {
        return ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          emissionFrequency: 0.8,
          minimumSize: const Size(10, 10),
          maximumSize: const Size(50, 50),
          numberOfParticles: 3,
          gravity: 0.5,
          shouldLoop: false,
          colors: [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: AppController.to.seasons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      crossAxisCount: orientation == Orientation.landscape ? 4 : 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppController.to.seasons[index].url),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  constraints: BoxConstraints.expand(height: 25),
                                  color: Colors.white.withOpacity(0.6),
                                  child: Center(
                                    child: Text(
                                      '${AppController.to.seasons[index].name}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600, fontFamily: 'MontserratAlternates'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TargetMonth(
                                  season: AppController.to.seasons[index],
                                  monthIndex: 0,
                                  nbSuccess: nbGoodAnswers,
                                ),
                                TargetMonth(
                                  season: AppController.to.seasons[index],
                                  monthIndex: 1,
                                  nbSuccess: nbGoodAnswers,
                                ),
                                TargetMonth(
                                  season: AppController.to.seasons[index],
                                  monthIndex: 2,
                                  nbSuccess: nbGoodAnswers,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: AppController.to.months.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: orientation == Orientation.landscape ? 2 : 1.15,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    crossAxisCount: orientation == Orientation.landscape ? 6 : 4,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return DraggableMonth(month: AppController.to.months[index]);
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _success() async {
    //final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    _confettiController.play();
    await AssetsAudioPlayer.newPlayer().open(Audio(Constants.kSoundLevelUp));
    //await widget.story.getStreamingUrls();
    AppController.to.initMonths();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => VimeoIframeScreen(
            story: widget.story,
          ),
        ),
      );
    });
  }
}
