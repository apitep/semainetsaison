import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'orderable.dart';
import 'orderable_stack.dart';

/// internal stack
class OrderableContainer<T> extends StatefulWidget {
  final List<OrderableWidget<T>> uiItems;

  final Size itemSize;
  final Direction direction;
  final double margin;

  OrderableContainer({@required this.uiItems, @required this.itemSize, this.margin = kMargin, this.direction = Direction.Horizontal})
      : super(key: Key('OrderableContainer'));

  @override
  State<StatefulWidget> createState() => new OrderableContainerState();
}

class OrderableContainerState extends State<OrderableContainer> {
  @override
  Widget build(BuildContext context) => new ConstrainedBox(
      constraints: BoxConstraints.loose(stackSize),
      child: Stack(
        children: widget.uiItems,
      ));

  Size get stackSize => widget.direction == Direction.Horizontal
      ? Size((widget.itemSize.width + widget.margin) * widget.uiItems.length, widget.itemSize.height)
      : Size(widget.itemSize.width, (widget.itemSize.height + widget.margin) * widget.uiItems.length);
}

/// Content Widget wrapper : add animation and gestureDetection to itemBuilder
/// widgets
class OrderableWidget<T> extends StatefulWidget {
  final Orderable<T> data;
  final Size itemSize;
  final double maxPos;
  final Direction direction;
  final VoidCallback onMove;
  final VoidCallback onDrop;
  final double step;
  final WidgetFactory<T> itemBuilder;

  OrderableWidget(
      {Key key,
      @required this.data,
      @required this.itemBuilder,
      @required this.maxPos,
      @required this.itemSize,
      this.onMove,
      this.onDrop,
      bool isDragged = false,
      this.direction = Direction.Horizontal,
      this.step = 0.0})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => new OrderableWidgetState(data: data);
}

class OrderableWidgetState<T> extends State<OrderableWidget<T>> with SingleTickerProviderStateMixin {
  FlutterTts flutterTts;
  dynamic languages;
  String language;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  @override
  void initState() {
    initTts();
    super.initState();
  }

  /// item
  Orderable<T> data;

  bool get isHorizontal => widget.direction == Direction.Horizontal;

  OrderableWidgetState({this.data});

  @override
  Widget build(BuildContext context) => new AnimatedPositioned(
        duration: Duration(milliseconds: data.selected ? 1 : 200),
        left: data.x,
        top: data.y,
        child: buildGestureDetector(horizontal: isHorizontal),
      );

  /// build horizontal or verticak drag gesture detector
  Widget buildGestureDetector({bool horizontal}) => horizontal
      ? GestureDetector(
          onHorizontalDragStart: startDrag,
          onHorizontalDragEnd: endDrag,
          onHorizontalDragUpdate: (event) {
            setState(() {
              if (moreThanMin(event) && lessThanMax(event)) data.currentPosition = Offset(data.x + event.primaryDelta, data.y);
              widget.onMove();
            });
          },
          child: widget.itemBuilder(data: data, itemSize: widget.itemSize),
        )
      : GestureDetector(
          onVerticalDragStart: startDrag,
          onVerticalDragEnd: endDrag,
          onVerticalDragUpdate: (event) {
            setState(() {
              if (moreThanMin(event) && lessThanMax(event)) data.currentPosition = Offset(data.x, data.y + event.primaryDelta);
              widget.onMove();
            });
          },
          child: widget.itemBuilder(data: data, itemSize: widget.itemSize),
        );

  void startDrag(DragStartDetails event) {
    speak("${data.value}");
    setState(() {
      data.selected = true;
    });
  }

  void endDrag(DragEndDetails event) {
    setState(() {
      data.selected = false;
      widget.onDrop();
    });
  }

  void initTts() async {
    if (Platform.isMacOS) return;

    flutterTts = FlutterTts();
    flutterTts.setLanguage('fr-FR');
    await flutterTts.isLanguageAvailable('fr-FR');
    flutterTts.setSpeechRate(.4);
    flutterTts.setVolume(1.0);
    flutterTts.setPitch(.8);

    flutterTts = FlutterTts();
  }

  void speak(String textToSpeak) async {
    await flutterTts.speak(textToSpeak);
  }

  bool moreThanMin(DragUpdateDetails event) => (isHorizontal ? data.x : data.y) + event.primaryDelta > 0;

  bool lessThanMax(DragUpdateDetails event) =>
      (isHorizontal ? data.x : data.y) + event.primaryDelta + (isHorizontal ? widget.itemSize.width : widget.itemSize.height) < widget.maxPos;
}
