import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();
  }

  List<String> chars = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"];

  ValueNotifier<String> orderNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remets dans l'ordre les jours de la semaine"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 20),
              Center(
                  child: OrderableStack<String>(
                      direction: Direction.Vertical,
                      items: chars,
                      itemSize: const Size(220.0, 50.0),
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
          style: TextStyle(fontSize: 36.0, color: Colors.white),
        )
      ])),
    );
  }

  Widget imgItemBuilder({Orderable<Img> data, Size itemSize}) => Container(
        color: data != null && !data.selected ? data.dataIndex == data.visibleIndex ? Colors.lime : Colors.cyan : Colors.orange,
        width: itemSize.width,
        height: itemSize.height,
        child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image.asset(
            data.value.url,
            fit: BoxFit.contain,
          ),
        ])),
      );
}

class Img {
  final String url;
  final String title;
  const Img(this.url, this.title);

  @override
  String toString() => 'Img{title: $title}';
}
