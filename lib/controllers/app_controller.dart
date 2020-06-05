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

  void init() {
    soundController = Get.put<SoundController>(SoundController());
    soundController.init();
  }
}
