import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

import '../constants.dart';
import '../widgets/topbar.dart';
import '../widgets/orderable_stack/orderable_stack.dart';
import '../widgets/orderable_stack/orderable.dart';
import '../screens/videoplayer_screen.dart';
import '../models/story.dart';

class MonthsScreen extends StatefulWidget {
  MonthsScreen({Key key, this.story}) : super(key: key);

  Story story;

  @override
  _MonthsScreenState createState() => _MonthsScreenState();
}

class _MonthsScreenState extends State<MonthsScreen> {
  ConfettiController _controllerCenter;
  ValueNotifier<String> orderNotifier = ValueNotifier<String>('');
  List<String> rightOrder = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 1));
    initPlayer();
    super.initState();
  }

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
    return Scaffold(
      backgroundColor: Constants.kColorBgStart,
      appBar: topBar(context, Constants.kTitle),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirection: 0, // radial value - RIGHT
            emissionFrequency: 0.6,
            minimumSize: const Size(10, 10),
            maximumSize: const Size(50, 50),
            numberOfParticles: 1,
            gravity: 0.1, // don't specify a direction, blast randomly
            shouldLoop: false, // start again as soon as the animation is finished
            colors: [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.story.thumbUrl),
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Stack(
                        children: <Widget>[
                          Container(color: Color.fromRGBO(255, 255, 255, 0.19)),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Fais glisser les mois dans l'ordre",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, fontFamily: 'MontserratAlternates', color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: OrderableStack<String>(
                        direction: Direction.Vertical,
                        items: rightOrder,
                        itemSize: const Size(120.0, 27.0),
                        itemBuilder: itemBuilder,
                        onChange: (List<String> orderedList) {
                          orderNotifier.value = orderedList.toString();
                          if (listEquals(orderedList, rightOrder)) _success();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemBuilder({Orderable<String> data, Size itemSize}) {
    return Container(
      key: Key("orderableDataWidget${data.dataIndex}"),
      color: data != null && !data.selected ? data.dataIndex == data.visibleIndex ? Colors.green : Colors.red : Colors.blue,
      width: itemSize.width,
      height: itemSize.height,
      child: Center(
          child: Column(children: [
        Text(
          "${data.value}",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        )
      ])),
    );
  }

  _success() async {
    _controllerCenter.play();
    audioCache.play('sounds/applause.mp3');
    await widget.story.getStreamingUrls();

    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => VideoPlayerScreen(title: widget.story.title, url: widget.story.videoUrl),
        ),
      );
    });
  }
}
