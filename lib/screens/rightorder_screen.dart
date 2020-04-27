import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/story.dart';
import '../providers/app_provider.dart';
import '../widgets/topbar.dart';
import '../widgets/orderable_stack/orderable_stack.dart';
import '../widgets/orderable_stack/orderable.dart';
import '../screens/trains/train_screen.dart';

class RightOrderScreen extends StatefulWidget {
  RightOrderScreen({Key key, this.story, this.rightOrder}) : super(key: key);
  static const routeName = '/rightorder';
  final Story story;
  final List<String> rightOrder;

  @override
  _RightOrderScreenState createState() => _RightOrderScreenState();
}

class _RightOrderScreenState extends State<RightOrderScreen> {
  AppProvider appProvider;
  ConfettiController _confettiController;
  ValueNotifier<String> orderNotifier = ValueNotifier<String>('');

  final String kDescriptionDays = "Glisse les jours de la semaine dans le bon ordre";
  final String kDescriptionMonths = "Glisse les mois de l'année dans le bon ordre";

  @override
  void initState() {
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
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
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                setState(() {
                  if (widget.rightOrder.length == 7) {
                    appProvider.speak(kDescriptionDays);
                  } else {
                    appProvider.speak(kDescriptionMonths);
                  }
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

  Widget itemBuilder({Orderable<String> data, Size itemSize}) {
    return Container(
      key: Key("orderableDataWidget${data.dataIndex}"),
      width: itemSize.width,
      height: itemSize.height,
      decoration: BoxDecoration(
        color: data != null && !data.selected ? data.dataIndex == data.visibleIndex ? Colors.green : Colors.red : Colors.blue,
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.white12, width: 4.0),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 8.0,
            spreadRadius: 2.0,
            offset: Offset(
              1.0, // horizontal
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
              child: Icon(Icons.calendar_today, color: Colors.white, size: 25), // button pressed
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
    _confettiController.play(); //launch confettis
    AssetsAudioPlayer.newPlayer().open(Audio(Constants.kSoundLevelUp)); //play sound levelUp

    Timer(Duration(seconds: 6), () {
      if (widget.rightOrder == Constants.days) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RightOrderScreen(story: widget.story, rightOrder: Constants.months)));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => TrainScreen(
                      story: widget.story,
                      wagons: Constants.days,
                    )));
      }
    });
  }
}
