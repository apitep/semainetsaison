import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:after_layout/after_layout.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

import '../constants.dart';
import '../models/story.dart';
import '../widgets/topbar.dart';
import '../widgets/orderable_stack/orderable_stack.dart';
import '../widgets/orderable_stack/orderable.dart';
import '../screens/train_screen.dart';

class RightOrderScreen extends StatefulWidget {
  RightOrderScreen({Key key, this.story, this.rightOrder}) : super(key: key);

  final Story story;
  final List<String> rightOrder;

  @override
  _RightOrderScreenState createState() => _RightOrderScreenState();
}

class _RightOrderScreenState extends State<RightOrderScreen> with AfterLayoutMixin<RightOrderScreen> {
  ConfettiController _controllerCenter;
  ValueNotifier<String> orderNotifier = ValueNotifier<String>('');
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 1));
    initPlayer();
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {

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
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.35), BlendMode.dstATop),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: topBar(context, "Glisse les mois\ndans le bon ordre"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - kToolbarHeight * 2,
                    child: Center(
                      child: OrderableStack<String>(
                        direction: Direction.Vertical,
                        items: widget.rightOrder,
                        itemSize: const Size(120.0, 27.0),
                        itemBuilder: itemBuilder,
                        onChange: (List<String> orderedList) {
                          orderNotifier.value = orderedList.toString();
                          if (listEquals(orderedList, widget.rightOrder)) _success();
                        },
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

  Widget itemBuilder({Orderable<String> data, Size itemSize}) {
    return Container(
      key: Key("orderableDataWidget${data.dataIndex}"),
      width: itemSize.width,
      height: itemSize.height,
      decoration: BoxDecoration(
        color: data != null && !data.selected ? data.dataIndex == data.visibleIndex ? Colors.green : Colors.red : Colors.blue,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15.0,
            spreadRadius: 2.0,
            offset: Offset(
              3.0, // horizontal
              3.0, // vertical
            ),
          )
        ],
      ),
      child: Center(
          child: Column(children: [
        Text(
          "${data.value}",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        )
      ])),
    );
  }

  void showHelloWorld() {
    showDialog(
      context: context,
      builder: (_) => NetworkGiffyDialog(
        image: Image.network(
          widget.story.thumbUrl,
          fit: BoxFit.cover,
        ),
        title: Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 18),
            children: <TextSpan>[
              TextSpan(
                text: '${widget.story.title}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: widget.story.title.length < 22 ? 16 : 13,
                  fontFamily: 'MontserratAlternates',
                  decoration: TextDecoration.none,
                ),
              ),
              widget.story.author.length < 40 ? TextSpan(text: "\n") : TextSpan(text: " "),
              TextSpan(
                text: "de ${widget.story.author}",
                style: TextStyle(
                  fontSize: widget.story.author.length < 30 ? 13 : 11,
                  fontFamily: 'MontserratAlternates',
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        description: Text(
          "Un album animé offert par l'école des loisirs. Fais glisser les mois dans l'ordre pour le regarder.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        entryAnimation: EntryAnimation.TOP,
        buttonOkText: Text('jouer', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white)),
        onlyOkButton: true,
        onOkButtonPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  _success() async {
    _controllerCenter.play();
    audioCache.play('sounds/success.mp3');

    Timer(Duration(seconds: 4), () {
      if (widget.rightOrder == Constants.months) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RightOrderScreen(story: widget.story, rightOrder: Constants.days)));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TrainScreen(story: widget.story)));
      }
    });
  }
}
