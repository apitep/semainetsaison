import 'dart:async';
import 'package:flutter/material.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:confetti/confetti.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/app_provider.dart';
import '../models/month.dart';
import '../models/story.dart';
import '../widgets/draggable_month.dart';
import '../widgets/topbar.dart';
import '../screens/videoplayer_screen.dart';

const String kDescription = "Place dans l'ordre les mois de l'année correspondant à chaque saison";

class FourSeasonScreen extends StatefulWidget {
  FourSeasonScreen({Key key, this.story}) : super(key: key);
  static const routeName = '/season';
  final Key key = UniqueKey();

  final Story story;

  @override
  _FourSeasonScreenState createState() => _FourSeasonScreenState();
}

class _FourSeasonScreenState extends State<FourSeasonScreen> {
  AppProvider appProvider;
  ConfettiController _confettiController;

  ValueNotifier<int> nbGoodAnswers = ValueNotifier<int>(0);
  int nbQuestions = 12;
  Color targetColor = Colors.white.withOpacity(0.1);
  Color overTargetColor = Colors.green.withOpacity(0.7);
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
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: Constants.kColorBgStart,
      appBar: topBar(context, Constants.kTitle),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: appProvider.seasons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(appProvider.seasons[index].url),
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
                                  '${appProvider.seasons[index].name}',
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
                            DragTarget(
                              onWillAccept: (data) {
                                return true;
                              },
                              onAccept: (Month data) {
                                if (goodAnswer(data, appProvider.seasons[index].name, 0)) {
                                  appProvider.months.singleWhere((item) {
                                    return (item.name == data.name);
                                  }).successful = true;
                                  dragMonthIndex = appProvider.months.indexOf(data);
                                }
                              },
                              builder: (
                                BuildContext context,
                                List<dynamic> accepted,
                                List<dynamic> rejected,
                              ) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: DottedBorder(
                                    padding: const EdgeInsets.all(2.0),
                                    strokeWidth: 1,
                                    child: Container(
                                      width: 130,
                                      height: 25,
                                      color: accepted.isEmpty
                                          ? (appProvider.months.singleWhere((item) {
                                              return (item.name == appProvider.seasons[index].months[0]);
                                            }).successful
                                              ? overTargetColor
                                              : targetColor)
                                          : overTargetColor,
                                      child: Text(
                                        appProvider.months.singleWhere((item) {
                                          return (item.name == appProvider.seasons[index].months[0]);
                                        }).successful
                                            ? '${appProvider.months[dragMonthIndex].name}'
                                            : '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600, fontFamily: 'MontserratAlternates'),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            DragTarget(
                              onWillAccept: (data) {
                                return true;
                              },
                              onAccept: (Month data) {},
                              builder: (
                                BuildContext context,
                                List<dynamic> accepted,
                                List<dynamic> rejected,
                              ) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DottedBorder(
                                    padding: const EdgeInsets.all(2.0),
                                    strokeWidth: 1,
                                    child: Container(
                                      width: 130,
                                      height: 25,
                                      color: accepted.isEmpty ? targetColor : overTargetColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                            DragTarget(
                              onWillAccept: (data) {
                                return true;
                              },
                              onAccept: (Month data) {
                                if (goodAnswer(data, appProvider.seasons[index].name, 2)) {}
                              },
                              builder: (
                                BuildContext context,
                                List<dynamic> accepted,
                                List<dynamic> rejected,
                              ) {
                                return DottedBorder(
                                  padding: const EdgeInsets.all(2.0),
                                  strokeWidth: 1,
                                  child: Container(
                                    width: 130,
                                    height: 25,
                                    color: accepted.isEmpty ? targetColor : overTargetColor,
                                  ),
                                );
                              },
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
              itemCount: appProvider.months.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.15,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                return DraggableMonth(month: appProvider.months[index]);
              },
            ),
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 0, // radial value - RIGHT
              emissionFrequency: 0.7,
              minimumSize: const Size(10, 10),
              maximumSize: const Size(50, 50),
              numberOfParticles: 1,
              gravity: 0.3, // don't specify a direction, blast randomly
              shouldLoop: false, // start again as soon as the animation is finished
              colors: [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
            ),
          ],
        ),
      ),
    );
  }

  bool goodAnswer(Month month, String season, int position) {
    bool result = false;

    var selectedSeason = appProvider.seasons.singleWhere((item) {
      return (item.name == season);
    });
    print(selectedSeason.name);

    if (month.name == selectedSeason.months[position]) {
      result = true;
    } else {
      print(month);
      print(season);
      print(position);
      print(selectedSeason.months[position]);
    }

    return result;
  }

  _success() async {
    appProvider.initMonths();
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    _confettiController.play();
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
