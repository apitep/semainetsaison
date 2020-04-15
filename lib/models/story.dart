import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'video.dart';

class Story {
  Story(this.title, this.author, this.thumbUrl, this.videoUrl);

  String title;
  String author;
  String thumbUrl;
  String videoUrl;

  List<Video> videos = List<Video>();

  //
  Future<void> getStreamingUrls() async {
    videos = await getVideos();
  }

  Future<List<Video>> getVideos() async {
    String jsondata;
    dynamic _response;

    _response = await http.get(videoUrl);
    if (_response.statusCode == 200) jsondata = _response.body;

    return parseVideos(jsondata);
  }

  List<Video> parseVideos(String jsondata) {
    if (jsondata == null) return [];

    final parsed = json.decode(jsondata.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Video>((json) => Video.fromJson(json)).toList();
  }

  Story.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    thumbUrl = json['thumbUrl'];
    videoUrl = json['videoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['title'] = this.title;
    data['author'] = this.author;
    data['thumbUrl'] = this.thumbUrl;
    data['videoUrl'] = this.videoUrl;

    return data;
  }
}
