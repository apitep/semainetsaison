import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/season.dart';

class SeasonService {
  SeasonService({this.seasonUrl});

  String seasonUrl;

  List<Season> seasons = List<Season>();

  ///
  Future<List<Season>> getSeasons() async {
    String jsondata;
    dynamic _response;

    _response = await http.get(seasonUrl);
    if (_response == null) {
      Get.snackbar("SeasonService:Erreur", "impossible d'accéder à l'url: $seasonUrl");
    } else {
      if (_response.statusCode == 200) jsondata = _response.body;
    }

    return parseSeasons(jsondata);
  }

  List<Season> parseSeasons(String jsondata) {
    if (jsondata == null) return [];

    dynamic _response;

    _response = json.decode(jsondata);
    if (_response == null) {
      Get.snackbar("SeasonService:Erreur", "impossible de décoder le json: $jsondata");
    } else {
      return _response.map<Season>((json) => Season.fromJson(json)).toList();
    }

    return [];
  }
}
