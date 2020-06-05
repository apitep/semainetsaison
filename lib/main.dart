import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/startup_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final String appTitle = "L'école des loisirs après le travail";

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      initialRoute: '/',
      namedRoutes: {
        '/': GetRoute(page: StartupScreen()),
      },
    );
  }
}
