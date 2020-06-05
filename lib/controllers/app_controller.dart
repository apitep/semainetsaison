import 'dart:convert';
import 'dart:math';

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

  Story get randomStory {
    return stories[Random().nextInt(stories.length)];
  }

  final isfetching = false.obs;
  final nbSuccess = 0.0.obs;

  void init() {
    soundController = Get.put<SoundController>(SoundController());
    soundController.init();
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
}
