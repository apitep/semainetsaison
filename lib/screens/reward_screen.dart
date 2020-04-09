import 'package:flutter/material.dart';
import '../widgets/assetvideo.dart';

class RewardScreen extends StatefulWidget {
  RewardScreen({Key key, this.url}) : super(key: key);
  final String url;

  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  ValueNotifier<String> orderNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AssetVideo(url: widget.url),
      ),
    );
  }
}
