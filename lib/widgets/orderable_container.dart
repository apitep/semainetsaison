import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OrderableContainer extends StatefulWidget {
  bool isPositionRight;
  final String value;
  final Size size;

  OrderableContainer({@required this.isPositionRight, this.value, this.size});

  @override
  _OrderableContainerState createState() => _OrderableContainerState();
}

class _OrderableContainerState extends State<OrderableContainer> {
  int index;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: widget.size.height,
      decoration: BoxDecoration(
        color: widget.isPositionRight ? Colors.green : Colors.red,
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.white12, width: 4.0),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(0.0),
          bottomLeft: const Radius.circular(0.0),
          topRight: const Radius.elliptical(150, 70),
          bottomRight: const Radius.elliptical(150, 70),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: Offset(
              1.0, // horizontal
              1.0, // vertical
            ),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Material(
              color: Colors.transparent, // button color
              child: Icon(Icons.calendar_today, color: Colors.white, size: 20),
            ),
            Text(
              '${widget.value}',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            )
          ]),
        ),
      ),
    );
  }
}
