import 'dart:convert';
import 'package:http/http.dart' as http;

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
    var video = videos.firstWhere((item) => item.quality == '540p');
    if (video != null) videoUrl = video.url;
  }

  Future<List<Video>> getVideos() async {
     Map<String, String> headers = {"Access-Control-Allow-Origin": "http://127.0.0.1:8080"};

    dynamic _response = await http.get(videoUrl, headers: headers);

    if (_response.statusCode == 200 || _response.statusCode == 201) {
      if (_response.body != null) return parseVideos(_response.body);
    }

    return List<Video>();
  }

  List<Video> parseVideos(String jsondata) {
    if (jsondata == null) return [];

    var resp = json.decode(jsondata);
    var urls = resp["request"]["files"]["progressive"];
    if (urls != null) return urls.map<Video>((json) => Video.fromJson(json)).toList();

    return [];
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
