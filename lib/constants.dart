import 'dart:math';

import 'package:flutter/material.dart';

class Constants {
  static String appName = "Les jours\nles mois\net les saisons";

  static final Color kColorBgStart = Color(0xFF264467);
  static final Color kColorLightGray = Color(0xFFececec);
  static final Color kColorLightGreen = Color(0xFF55CEC8);

  static const String kTitle = "Les jours, les mois\net les saisons";

  static const String kUrlRemoteRoot = "https://raw.githubusercontent.com/apitep/semainetsaison/master/";

  static const String kUrlData = kUrlRemoteRoot + "assets/data/";
  static const String kUrlImages = kUrlRemoteRoot + "assets/images/";
  static const String kUrlStories = kUrlRemoteRoot + "assets/data/stories.json";
  static const String kUrlSeasons = kUrlRemoteRoot + "assets/data/seasons_fr-FR.json";

  static const String kSoundLevelUp = "assets/sounds/levelup.mp3";
  static const String kSoundGood = "assets/sounds/good.mp3";
  static const String kSoundHomeIntro = "assets/sounds/homeintro.mp3";
  static const String kSoundTrainVapeur = "assets/sounds/trainvapeur.mp3";
  static const String kSoundTrainSifflement = "assets/sounds/tutut.mp3";
  static const String kBackgroundAudioLow = "assets/sounds/ambiance_low.mp3";
  static const String kBackgroundAudio = "assets/sounds/ambiance.mp3";

  static final Widget kApitepLogo = Image.asset('assets/images/ApitepBearLogo.png', height: 100);
  static final Widget kVictoryBadge = Image.asset('assets/images/VictoryBadge.png', height: 35);

  static final List<String> months = ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"];
  static final List<String> days = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"];
  static final List<List<String>> kSeasons = [
    ["hiver", "décembre", "janvier", "février"],
    ["printemps", "mars", "avril", "mai"],
    ["été", "juin", "juillet", "août"],
    ["automne", "septembre", "octobre", "novembre"],
  ];

  //Colors for theme
  static Color lightPrimary = Color(0xfff3f4f9);
  static Color darkPrimary = Color(0xff2B2B2B);
  static Color lightAccent = Color(0xff597ef7);
  static Color darkAccent = Color(0xff597ef7);
  static Color lightBG = Color(0xfff3f4f9);
  static Color darkBG = Color(0xff2B2B2B);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 1,
      textTheme: TextTheme(
        headline5: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        headline5: TextStyle(
          color: lightBG,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  static Map<String, String> languages = {
    'fr-FR': 'fr-FR',
    'gb-GB': 'gb-GB',
    'nl-NL': 'nl-NL',
    'es-ES': 'es-ES',
  };
}
