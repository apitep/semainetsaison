import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audio_cache.dart';

import '../constants.dart';
import '../models/story.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    initPlayer();
    fetchData();
    musicBackground(true);
  }

  AudioCache music;
  List<Story> stories = List<Story>();
  ThemeData theme = Constants.lightTheme;
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String appVersion;

  bool _isMusicPlaying = false;
  bool get isMusicPlaying => _isMusicPlaying;
  set isMusicPlaying(bool newValue) {
    _isMusicPlaying = newValue;
    notifyListeners();
  }

  bool _isfetching = false;
  bool get isfetching => _isfetching;
  set isfetching(bool newValue) {
    _isfetching = newValue;
    notifyListeners();
  }

  //
  Future<void> fetchData() async {
    stories = await getStories();
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

  void initPlayer() {
    music = AudioCache();
  }

  void musicBackground(bool play) {
    play ? music.loop('sounds/ambiance_low.mp3') : music.clear('sounds/ambiance_low.mp3');
    isMusicPlaying = play;
  }

  void setKey(value) {
    key = value;
    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
    notifyListeners();
  }
}
