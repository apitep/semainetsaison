import 'package:flutter/material.dart';

import '../models/wagon_word.dart';
import 'wordcard.dart';

class WordSlider extends StatefulWidget {
  WordSlider({Key key, this.words}) : super(key: key);

  final List<WagonWord> words;

  @override
  _WordSliderState createState() => _WordSliderState();
}

class _WordSliderState extends State<WordSlider> {
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
        itemCount: widget.words.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 20,
          mainAxisSpacing: 0,
          crossAxisCount: 1,
        ),
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: WordCard(widget.words[index]),
          onTap: () {},
        ),
      ),
    );
  }
}
