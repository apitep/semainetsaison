import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';
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
  Offset position = Offset(0.0, 0.0);
    AppProvider appProvider;

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return Draggable(
      data: widget.month,
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
