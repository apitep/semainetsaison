import 'dart:convert';
import 'package:http/http.dart' as http;

import 'video.dart';
import 'vimeo_embed.dart';

class Story {
  int id;
  String title;
  String author;
  String thumbUrl;
  String videoUrl;
  List<Video> videos = <Video>[];

  Story(this.id, this.title, this.author, this.thumbUrl, this.videoUrl) {
    getVideoEmberUrl();
  }

  ///
  void getVideoEmberUrl() async {
    VimeoEmbed embed;
    var url = 'https://vimeo.com/api/oembed.json?url=https://vimeo.com/$id';
    print(url);

    await http.get(url).then((response) {
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body != null) {
          var data = json.decode(response.body);
          embed = VimeoEmbed.fromJson(data);
          print(embed.html);

          var regexp = RegExp(r'/vimeo\.com\/([0-9]+)\//i');
          final match = regexp.firstMatch(embed.html);
          print(match);
        }
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<void> getStreamingUrls() async {
    videos = await getVideos();
    var video = videos.firstWhere((item) => item.quality == '540p');
    if (video != null) videoUrl = video.url;
  }

  Future<List<Video>> getVideos() async {
    //Map<String, String> headers = {"Access-Control-Allow-Origin": "http://127.0.0.1:8080"};
    var headers = <String, String>{'Access-Control-Allow-Origin': '*'};

    print(videoUrl);
    dynamic _response = await http.get(videoUrl, headers: headers);

    if (_response.statusCode == 200 || _response.statusCode == 201) {
      if (_response.body != null) return parseVideos(_response.body);
    }

    return <Video>[];
  }

  List<Video> parseVideos(String jsondata) {
    if (jsondata == null) return [];

    var resp = json.decode(jsondata);
    var urls = resp['request']['files']['progressive'];
    if (urls != null) return urls.map<Video>((json) => Video.fromJson(json)).toList();

    return [];
  }

  ///
  Story.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    thumbUrl = json['thumbUrl'];
    videoUrl = json['videoUrl'];

    getVideoEmberUrl();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['thumbUrl'] = thumbUrl;
    data['videoUrl'] = videoUrl;

    return data;
  }
}
