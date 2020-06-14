import 'package:flutter/material.dart';

class Month {
  String name;
  bool successful;
  Color bgColor = Colors.green.withOpacity(0.7);

  Month(this.name, {this.successful = false, this.bgColor});
}