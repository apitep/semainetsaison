import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/season.dart';

class SeasonService {
  SeasonService({this.seasonUrl});

  String seasonUrl;

  List<Season> seasons = List<Season>();

  ///
  Future<List<Season>> getSeasons() async {
    Map<String, String> headers = {"Access-Control-Allow-Origin": "http://127.0.0.1:8080"};

    dynamic _response = await http.get(seasonUrl, headers: headers);

    if (_response.statusCode == 200 || _response.statusCode == 201) {
      if (_response.body != null) return parseSeasons(_response.body);
    }

    return List<Season>();
  }

  List<Season> parseSeasons(String jsondata) {
    if (jsondata == null) return [];

    var resp = json.decode(jsondata);
    if (resp != null) return resp.map<Season>((json) => Season.fromJson(json)).toList();

    return [];
  }
}
