class Story {
  Story(this.title, this.author, this.thumbUrl, this.videoUrl);

  String title;
  String author;
  String thumbUrl;
  String videoUrl;

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
