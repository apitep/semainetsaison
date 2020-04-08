import 'package:flutter/material.dart';

import '../widgets/orderable_stack/orderable_stack.dart';
import '../widgets/orderable_stack/orderable.dart';

class MonthsScreen extends StatefulWidget {
  MonthsScreen({Key key}) : super(key: key);

  @override
  _MonthsScreenState createState() => _MonthsScreenState();
}

const kItemSize = const Size.square(80.0);
const kChars = const ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];

class _MonthsScreenState extends State<MonthsScreen> {
  List<String> chars = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];

  ValueNotifier<String> orderNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remets dans l'ordre les 12 mois de l'année"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 20),
              //preview,
              Center(
                  child: OrderableStack<String>(
                      direction: Direction.Vertical,
                      items: chars,
                      itemSize: const Size(120.0, 27.0),
                      itemBuilder: itemBuilder,
                      onChange: (List<String> orderedList) => orderNotifier.value = orderedList.toString()))
            ],
          ),
        ),
      ),
    );
  }

  Widget itemBuilder({Orderable<String> data, Size itemSize}) {
    return Container(
      key: Key("orderableDataWidget${data.dataIndex}"),
      color: data != null && !data.selected ? data.dataIndex == data.visibleIndex ? Colors.lime : Colors.cyan : Colors.orange,
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
}
