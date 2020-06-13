import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';

import '../constants.dart';
import '../widgets/orderable_container.dart';

class DaysOrderScreen extends StatefulWidget {
  @override
  _DaysOrderScreenState createState() => _DaysOrderScreenState();
}

class _DaysOrderScreenState extends State<DaysOrderScreen> {
  final tiles = List<OrderableContainer>().obs;

  @override
  void initState() {
    super.initState();
    Constants.days.forEach((item) {
      tiles.add(OrderableContainer(value: item, isPositionRight: true, size: const Size(145, 50)));
    });
  }

  void checkTilesPosition() {
    int index = 0;
    tiles.forEach((item) {
      item.isPositionRight = (Constants.days[index] == item.value);
      index++;
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      OrderableContainer item = tiles.removeAt(oldIndex);
      tiles.insert(newIndex, item);
      checkTilesPosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  //this callback is optional
                }),
          ],
        ),
      ),
    );
  }
  
}
