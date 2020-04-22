import 'dart:ui';
import 'package:flutter/material.dart';

import '../models/events.dart';
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
        alignment: Alignment.center,
        child: Container(
          width: widget.word.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            image: DecorationImage(
              image: AssetImage(widget.word.imagePath),
              fit: BoxFit.contain,
            ),
            boxShadow: [
              BoxShadow(blurRadius: 4, spreadRadius: 3, offset: Offset(0, 2), color: Colors.black.withOpacity(0.05)),
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
                    colors: [Colors.black.withOpacity(0.60), Colors.transparent],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 35,
                    width: widget.word.width,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.30),
                      border: Border.all(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: TextField(
                        onChanged: (value) => _handleOnChanged(value),
                        controller: _textfieldController,
                        textAlign: TextAlign.center,
                        autofocus: true,
                        readOnly: widget.word.disabled,
                        style: TextStyle(
                          fontSize: 16,
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
        ),
      ),
    );
  }

  _handleOnChanged(String value) {
    setState(() {
      widget.word.answer = value.trim();
      if (widget.word.isAnswerRight()) eventBus.fire(CheckResult());
    });
  }
}
