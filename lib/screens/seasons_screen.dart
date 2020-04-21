import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:after_layout/after_layout.dart';
import 'package:confetti/confetti.dart';

import '../constants.dart';
import '../widgets/topbar.dart';
import '../widgets/wordslider.dart';
import '../screens/videoplayer_screen.dart';
import '../providers/app_provider.dart';
import '../models/wagon_word.dart';
import '../models/story.dart';

const kSeasons = {
  ["printemps", "avril", "mai", "juin"],
  ["été", "juillet", "août", "septembre"],
  ["automne", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"],
  ["hiver", "octobre", "novembre", "décembre"],
};

class SeasonScreen extends StatefulWidget {
  SeasonScreen({Key key, this.story}) : super(key: key);

  final Story story;

  @override
  _SeasonScreenState createState() => _SeasonScreenState();
}

class _SeasonScreenState extends State<SeasonScreen> with AfterLayoutMixin<SeasonScreen> {
  PageController pageController;
  ConfettiController _controllerCenter;
  AppProvider appProvider;
  AudioCache soundeffect;
  List<WagonWord> daytrain, monthtrain;
  double nbSuccess = 0;

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 1));
    initPlayer();
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    soundeffect.play('sounds/trainvapeur.mp3');
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    appProvider.musicBackground(false);
    super.dispose();
  }

  void initPlayer() {
    soundeffect = AudioCache();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);
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
                      'Le train des saisons',
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
                  getTrainsWidgets(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Complète les saisons avec les bon mois',
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

  Widget getTrainsWidgets() {
    List<Widget> trains = List<Widget>();
    kSeasons.map((season) {
      trains.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 170,
              child: WordSlider(words: loadTrain(season)),
            ),
          ],
        ),
      );
    });

    return Column(children: trains);
  }

  List<WagonWord> loadTrain(List<String> items) {
    return items.map((item) => WagonWord.wagon(item)).toList()..first.loco = true;
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
    soundeffect.play('sounds/levelup.mp3');
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
