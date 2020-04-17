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
  PageController pageController;
  double wordCardBaseWidth = 200;
  double wordContainerHeight = 100;

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
    this.pageController = PageController(
      viewportFraction: wordCardBaseWidth / MediaQuery.of(context).size.width,
    );
    return Container(
      height: wordContainerHeight,
      child: PageView.builder(
        controller: this.pageController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.words.length,
        itemBuilder: (ctx, index) {
          final word = widget.words[index];
          return WordCard(word);
        },
      ),
    );
  }
}
