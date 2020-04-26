import 'package:flutter/material.dart';

import '../../models/wagon_question.dart';
import 'train_wagon.dart';

class TrainSlider extends StatefulWidget {
  TrainSlider({Key key, @required this.wagons, @required this.nbSuccess}) : super(key: key);

  final List<WagonQuestion> wagons;
  final ValueNotifier<int> nbSuccess;

  @override
  _TrainSliderState createState() => _TrainSliderState();
}

class _TrainSliderState extends State<TrainSlider> {
  double wordContainerHeight = 150;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: wordContainerHeight,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.wagons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 20,
          mainAxisSpacing: 0,
          crossAxisCount: 1,
        ),
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: TrainWagon(word: widget.wagons[index], nbSuccess: widget.nbSuccess,),
          onTap: () {},
        ),
      ),
    );
  }
}
