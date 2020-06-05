import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:assets_audio_player/assets_audio_player.dart';

import '../constants.dart';
import '../models/wagon_question.dart';
import '../models/season.dart';
import '../models/month.dart';
import '../models/story.dart';
import '../services/season_service.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    fetchData();
  }

  FlutterTts flutterTts;
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  List<Story> stories = List<Story>();
  List<Season> seasons = List<Season>();
  List<Month> months = List<Month>();

  ThemeData theme = Constants.lightTheme;
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String appVersion;

  bool _isfetching = false;
  bool get isfetching => _isfetching;
  set isfetching(bool newValue) {
    _isfetching = newValue;
    notifyListeners();
  }

  double _nbSuccess = 0;
  double get nbSuccess => _nbSuccess;
  set nbSuccess(double newValue) {
    _nbSuccess = newValue;
    notifyListeners();
  }

  Story get randomStory {
    return stories[Random().nextInt(stories.length)];
  }

  //
  Future<void> fetchData() async {
    isfetching = true;
    stories = await getStories();
    seasons = await SeasonService(seasonUrl: Constants.kUrlSeasons).getSeasons();
    initMonths();
    isfetching = false;
  }

  Future<List<Story>> getStories() async {
    String url = Constants.kUrlStories;
    String jsondata;
    dynamic _response;

    _response = await http.get(url);
    if (_response.statusCode == 200) jsondata = _response.body;

    return parseStories(jsondata);
  }

  List<Story> parseStories(String jsondata) {
    if (jsondata == null) return [];

    final parsed = json.decode(jsondata.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Story>((json) => Story.fromJson(json)).toList();
  }

  void setKey(value) {
    key = value;
    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
    notifyListeners();
  }

  void initMonths() {
    months = List<Month>();
    seasons.forEach((season) {
      season.months.forEach((month) {
        months.add(Month(month));
      });
    });
  }

  List<WagonQuestion> loadTrain(List<String> items) {
    return items.map((item) => WagonQuestion.wagon(item)).toList()..first.loco = true;
  }
}
