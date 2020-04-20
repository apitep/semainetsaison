import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

import '../constants.dart';
import '../models/story.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    initPlayer();
    musicBackground(true);
    fetchData();
  }

  AudioPlayer music;
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
    music = AudioPlayer();
    music.setReleaseMode(ReleaseMode.LOOP);
  }

  void musicBackground(bool play) {
    play ? music.play(Constants.kUrlBackgroundAudioLow) : music.stop();
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
