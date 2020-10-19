import 'dart:async';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';

import '../controllers/app_controller.dart';

import '../constants.dart';
import '../widgets/topbar.dart';
import '../widgets/orderable_container.dart';
import '../models/story.dart';
import 'months_order_screen.dart';

class DaysOrderScreen extends StatefulWidget {
  DaysOrderScreen({Key key, this.story}) : super(key: key);
  final Story story;

  @override
  _DaysOrderScreenState createState() => _DaysOrderScreenState();
}

class _DaysOrderScreenState extends State<DaysOrderScreen> {
  ConfettiController _confettiController;
  final tiles = <OrderableContainer>[].obs;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    Constants.days.forEach((item) {
      tiles.add(OrderableContainer(value: item, isPositionRight: true, size: const Size(145, 50)));
    });
    tiles.value.shuffle();
    checkTilesPosition();
    Timer(Duration(seconds: 3), () {
      AppController.to.soundController.speak(Constants.descriptionDays);
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void checkTilesPosition() {
    var index = 0;
    var nbGoodPosition = 0;
    tiles.forEach((item) {
      if (Constants.days[index] == item.value) {
        item.isPositionRight = true;
        nbGoodPosition++;
      } else {
        item.isPositionRight = false;
      }
      index++;
      if (nbGoodPosition == tiles.length) _success();
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      var item = tiles.removeAt(oldIndex);
      tiles.insert(newIndex, item);
      checkTilesPosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ReorderableWrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  needsLongPressDraggable: false,
                  spacing: 20.0,
                  runSpacing: 30.0,
                  padding: const EdgeInsets.all(20),
                  children: tiles.value,
                  onReorder: _onReorder,
                  onReorderStarted: (int index) {
                    AppController.to.soundController.speak(tiles[index].value);
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                AppController.to.soundController.speak(Constants.descriptionDays);
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

  void _success() async {
    _confettiController.play(); //launch confettis
    await AssetsAudioPlayer.newPlayer().open(Audio(Constants.kSoundLevelUp)); //play sound levelUp

    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MonthsOrderScreen(story: widget.story)));
    });
  }
}
