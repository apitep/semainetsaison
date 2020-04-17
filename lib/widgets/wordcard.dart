import 'dart:ui';
import 'package:flutter/material.dart';

import '../models/wagon_word.dart';

class WordCard extends StatefulWidget {
  WordCard(this.word, {Key key}) : super(key: key);

  final WagonWord word;

  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  TextEditingController _textfieldController = TextEditingController();
  final padding = 2.0;
  final ratio = 0.5;

  @override
  void initState() {
    _textfieldController.text = widget.word.answer;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding * 2),
      child: Align(
        child: Container(
          width: widget.word.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            image: DecorationImage(
              image: AssetImage(widget.word.imagePath),
              fit: BoxFit.contain,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                spreadRadius: 2,
                offset: Offset(0, 2),
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.3),
              child: Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    stops: [0.3, 0.8],
                    colors: [
                      Colors.black.withOpacity(0.80),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: padding * 2,
                    vertical: padding,
                  ),
                  child: TextField(
                    onChanged: (value) => _handleOnChanged(value),
                    controller: _textfieldController,
                    textAlign: TextAlign.center,
                    autofocus: true,
                    readOnly: widget.word.disabled,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _handleOnChanged(String value) {
    setState(() {
      widget.word.answer = value;
      widget.word.isAnswerRight();
    });
  }
}
