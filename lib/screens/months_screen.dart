import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:confetti/confetti.dart';

import '../widgets/orderable_stack/orderable_stack.dart';
import '../widgets/orderable_stack/orderable.dart';

class MonthsScreen extends StatefulWidget {
  MonthsScreen({Key key}) : super(key: key);

  @override
  _MonthsScreenState createState() => _MonthsScreenState();
}

class _MonthsScreenState extends State<MonthsScreen> {
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

  ConfettiController _controllerCenter;
  ValueNotifier<String> orderNotifier = ValueNotifier<String>('');
  List<String> rightOrder = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remets dans l'ordre les 12 mois de l'année"),
      ),
      body: Center(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 20),
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
    );
  }

  Widget itemBuilder({Orderable<String> data, Size itemSize}) {
    return Container(
      key: Key("orderableDataWidget${data.dataIndex}"),
      color: data != null && !data.selected ? data.dataIndex == data.visibleIndex ? Colors.green : Colors.cyan : Colors.orange,
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

  _success() {
    _controllerCenter.play();
  }
}
