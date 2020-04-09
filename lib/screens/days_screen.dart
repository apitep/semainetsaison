import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:confetti/confetti.dart';

import '../widgets/orderable_stack/orderable_stack.dart';
import '../widgets/orderable_stack/orderable.dart';

class DaysScreen extends StatefulWidget {
  DaysScreen({Key key}) : super(key: key);

  @override
  _DaysScreenState createState() => _DaysScreenState();
}

const kItemSize = const Size.square(80.0);
const kChars = const ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"];

class _DaysScreenState extends State<DaysScreen> {

  ConfettiController _controllerCenter;
  ValueNotifier<String> orderNotifier = ValueNotifier<String>('');
  List<String> rightOrder = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"];

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 3));
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remets dans l'ordre les jours de la semaine"),
      ),
      body: Center(
        child: ConfettiWidget(
          confettiController: _controllerCenter,
          blastDirection: 0, // radial value - RIGHT
          emissionFrequency: 0.6,
          minimumSize: const Size(10, 10),
          maximumSize: const Size(50, 50),
          numberOfParticles: 1,
          gravity: 0.1,// don't specify a direction, blast randomly
          shouldLoop: false, // start again as soon as the animation is finished
          colors: [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 20),
                Center(
                  child: OrderableStack<String>(
                    direction: Direction.Vertical,
                    items: rightOrder,
                    itemSize: const Size(220.0, 50.0),
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
    );
  }

  Widget itemBuilder({Orderable<String> data, Size itemSize}) {
    return Container(
      key: Key("orderableDataWidget${data.dataIndex}"),
      color: data != null && !data.selected ? (data.dataIndex == data.visibleIndex ? Colors.lime : Colors.cyan) : Colors.orange,
      width: itemSize.width,
      height: itemSize.height,
      child: Center(
          child: Column(children: [
        Text(
          "${data.value}",
          style: TextStyle(fontSize: 36.0, color: Colors.white),
        )
      ])),
    );
  }

  _success() {
    _controllerCenter.play();
  }
}
