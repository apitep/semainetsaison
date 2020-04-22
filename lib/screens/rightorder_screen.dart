import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';

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

class _RightOrderScreenState extends State<RightOrderScreen> {
  ConfettiController _controllerCenter;
  ValueNotifier<String> orderNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ConfettiWidget(
          confettiController: _controllerCenter,
          blastDirection: 0, // radial value - RIGHT
          emissionFrequency: 0.7,
          minimumSize: const Size(10, 10),
          maximumSize: const Size(50, 50),
          numberOfParticles: 1,
          gravity: 0.2, // don't specify a direction, blast randomly
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
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OrderableStack<String>(
                    direction: Direction.Vertical,
                    items: widget.rightOrder,
                    itemSize: Size(170, 50),
                    itemBuilder: itemBuilder,
                    onChange: (List<String> orderedList) {
                      orderNotifier.value = orderedList.toString();
                      if (listEquals(orderedList, widget.rightOrder)) _success();
                    },
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
        color:
            data != null && !data.selected ? data.dataIndex == data.visibleIndex ? Colors.green.withOpacity(0.75) : Colors.red.withOpacity(0.50) : Colors.blue,
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.white12, width: 4.0),
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
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Material(
            color: Colors.transparent, // button color
            child: InkWell(
              splashColor: Constants.kColorBgStart, // splash color
              onTap: () {},
              child: Icon(Icons.calendar_today, size: 25), // button pressed
            ),
          ),
          Text(
            "${data.value}",
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          )
        ]),
      )),
    );
  }

  _success() async {
    _controllerCenter.play(); //launch confettis
    AssetsAudioPlayer.newPlayer().open(Audio(Constants.kSoundLevelUp)); //play sound levelUp

    Timer(Duration(seconds: 6), () {
      if (widget.rightOrder == Constants.days) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RightOrderScreen(story: widget.story, rightOrder: Constants.months)));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TrainScreen(story: widget.story)));
      }
    });
  }
}
