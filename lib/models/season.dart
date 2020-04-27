class Season {
  String name;
  String url;
  List<String> months = List<String>();
  bool successful = false;

  Season(this.name, this.url, this.months, this.successful);

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