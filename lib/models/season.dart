class Season {
  String name;
  String url;
  List<String> months = <String>[];
  bool successful = false;

  Season(this.name, this.url, this.months, this.successful);

  Season.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    months = List.from(json['months']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['name'] = name;
    data['url'] = url;
    data['months'] = months;

    return data;
  }
}
