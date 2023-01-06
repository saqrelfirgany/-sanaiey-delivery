class OrderModel {
  dynamic requestId;
  dynamic requestCaption;
  dynamic department;
  dynamic date;
  dynamic dayOfWeek;
  dynamic time;
  dynamic services;
  dynamic requestStatus;

  OrderModel({
    this.requestId,
    this.requestCaption,
    this.department,
    this.date,
    this.dayOfWeek,
    this.time,
    this.services,
    this.requestStatus,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    requestCaption = json['requestCaption'];
    department = json['department'];
    date = json['date'];
    dayOfWeek = json['dayOfWeek'];
    time = json['time'];
    services = json['services'];
    requestStatus = json['requestStatus'];
  }
}
