import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semainetsaison/providers/app_provider.dart';

import 'screens/startup_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String appTitle = "L'école des loisirs après le travail";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartupScreen(),
    );
  }
}
