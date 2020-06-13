import 'dart:convert';
import 'dart:math';

import 'package:cross_local_storage/cross_local_storage.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../controllers/sound_controller.dart';
import '../models/wagon_question.dart';
import '../models/season.dart';
import '../models/month.dart';
import '../models/story.dart';
import '../services/season_service.dart';

class AppController extends GetController {
  static AppController get to => Get.find();

  SoundController soundController;

  List<Story> stories = List<Story>();
  List<Season> seasons = List<Season>();
  List<Month> months = List<Month>();

  bool displayOnBoard = true;

  Story get randomStory {
    return stories[Random().nextInt(stories.length)];
  }

  final isfetching = false.obs;
  final nbSuccess = 0.0.obs;

  void init() async {
    soundController = Get.put<SoundController>(SoundController());
    soundController.init();
    displayOnBoard = await getDisplayOnBoard();
    fetchData();
  }

  //
  Future<void> fetchData() async {
    isfetching.value = true;
    stories = await getStories();
    seasons = await SeasonService(seasonUrl: Constants.kUrlSeasons).getSeasons();
    initMonths();
    isfetching.value = false;
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

  void setDisplayOnBoard(bool value) async {
    LocalStorageInterface prefs = await LocalStorage.getInstance();
    await prefs.setBool('displayOnBoard', value);
  }

  Future<bool> getDisplayOnBoard() async {
    LocalStorageInterface prefs = await LocalStorage.getInstance();
    bool value = prefs.getBool('displayOnBoard') ?? true;
    return value;
  }

  List<String> getRandomSeason() {
    int selected = pick(0, Constants.kSeasons.length - 1);
    return Constants.kSeasons[selected];
  }

  bool isPortrait() {
    return (Get.width > Get.height);
  }

  int pick(int a, int b) => a + Random().nextInt(b - a + 1);
}
