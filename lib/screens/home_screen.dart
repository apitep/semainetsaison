import 'package:flutter/material.dart';
import 'package:semainetsaison/widgets/topbar.dart';
import '../constants.dart';
import '../widgets/menu.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<String> orderNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kColorLightGreen,
      appBar: topBar(context, Constants.kTitle),
      body: Center(
        child: Menu(),
      ),
    );
  }
}
