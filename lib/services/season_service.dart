import 'dart:convert';
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
    if (_response.statusCode == 200) jsondata = _response.body;

    return parseSeasons(jsondata);
  }

  List<Season> parseSeasons(String jsondata) {
    if (jsondata == null) return [];

    var resp = json.decode(jsondata);
    if (resp != null) return resp.map<Season>((json) => Season.fromJson(json)).toList();

    return [];
  }
}
