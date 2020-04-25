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
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['quality'] = this.quality;
    data['width'] = this.width;
    data['url'] = this.url;

    return data;
  }
}
