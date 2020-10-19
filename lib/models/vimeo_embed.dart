class VimeoEmbed {
  String title;
  String thumbnailUrl;
  String html;
  int videoId;
  String uploadDate;
  int width;
  int height;

  VimeoEmbed(this.title, this.thumbnailUrl, this.html, this.videoId, this.uploadDate, this.width, this.height);

  ///
  VimeoEmbed.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbnailUrl = json['thumbnail_url'];
    html = json['html'];
    videoId = json['video_id'];
    uploadDate = json['upload_date'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['title'] = title;
    data['thumbnail_url'] = thumbnailUrl;
    data['html'] = html;
    data['video_id'] = videoId;
    data['upload_date'] = uploadDate;
    data['width'] = width;
    data['height'] = height;

    return data;
  }
}
