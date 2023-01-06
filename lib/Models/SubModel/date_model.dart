class DateModel {
  dynamic caption;
  dynamic time;

  DateModel({this.caption, this.time});

  DateModel.fromJson(Map<String, dynamic> json) {
    caption = json['caption'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caption'] = this.caption;
    data['time'] = this.time;
    return data;
  }
}