import 'package:flutter/material.dart';
import 'package:semainetsaison/screens/months_screen.dart';
import 'package:semainetsaison/widgets/menu.dart';

import 'widgets/responsive_widget.dart';
import 'screens/days_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jours Mois et Saisons',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Les jours, les mois et les saisons'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const kItemSize = const Size.square(80.0);

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<String> orderNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Menu(),
      ),
    );
  }
}
