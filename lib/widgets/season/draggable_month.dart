import 'package:flutter/material.dart';

import '../../models/month.dart';

class DraggableMonth extends StatefulWidget {
  final Offset initPos;
  final Month month;
  final Color dragColor;
  final Color itemColor;

  DraggableMonth({this.initPos, @required this.month, this.itemColor = Colors.blue, this.dragColor = Colors.orange});

  @override
  DraggableMonthState createState() => DraggableMonthState();
}

class DraggableMonthState extends State<DraggableMonth> {
  Offset position = Offset(100.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: widget.month,
      dragAnchor: DragAnchor.pointer,
      onDraggableCanceled: (velocity, offset) {
        if (mounted) {}
        setState(() {});
      },
      feedback: Container(
        width: 140,
        decoration: BoxDecoration(
          color: widget.dragColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Text(
              widget.month.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'MontserratAlternates', color: Colors.white),
            ),
          ),
        ),
      ),
      childWhenDragging: Container(
        padding: const EdgeInsets.all(2.0),
        child: DragItem(month: widget.month.name),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: widget.itemColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Text(
              widget.month.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'MontserratAlternates', color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class DragItem extends StatelessWidget {
  const DragItem({Key key, @required this.month}) : super(key: key);

  final String month;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        month,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'MontserratAlternates', color: Colors.white),
      ),
    );
  }
}
