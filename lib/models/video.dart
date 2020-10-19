class Video {
  String id;
  String quality;
  int width;
  String url;

  Video(this.id, this.quality, this.width, this.url);

  ///
  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quality = json['quality'];
    width = json['width'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['id'] = id;
    data['quality'] = quality;
    data['width'] = width;
    data['url'] = url;

    return data;
  }
}
