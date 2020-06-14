import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/startup_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    Application(),
  );
}

class Application extends StatelessWidget {
  final String appTitle = "L'école des loisirs après le travail";

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      initialRoute: '/',
      namedRoutes: {
        '/': GetRoute(page: StartupScreen()),
        '/onboarding': GetRoute(page: OnBoardingScreen()),
        '/home': GetRoute(page: HomeScreen()),
      },
    );
  }
}
