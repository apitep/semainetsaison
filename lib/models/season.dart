class Season {
  Season(this.name, this.url, this.months);

  String name;
  String url;

  List<String> months = List<String>();

  Season.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    months = List.from(json['months']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['url'] = this.url;
    data['months'] = this.months;

    return data;
  }
}