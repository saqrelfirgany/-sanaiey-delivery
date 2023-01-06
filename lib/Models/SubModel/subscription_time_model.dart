class SubscriptionsTimeModel {
  dynamic requestId;
  dynamic requestCaption;
  dynamic isCanceled;
  dynamic status;
  dynamic canAdd;
  dynamic day;
  dynamic preferredTime;
  dynamic dayOfTheWeek;

  SubscriptionsTimeModel({
    this.requestId,
    this.requestCaption,
    this.isCanceled,
    this.status,
    this.canAdd,
    this.day,
    this.preferredTime,
    this.dayOfTheWeek,
  });

  SubscriptionsTimeModel.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    requestCaption = json['requestCaption'];
    isCanceled = json['isCanceled'];
    status = json['status'];
    canAdd = json['canAdd'];
    day = json['day'];
    preferredTime = json['preferredTime'];
    dayOfTheWeek = json['dayOfTheWeek'];
  }
}
