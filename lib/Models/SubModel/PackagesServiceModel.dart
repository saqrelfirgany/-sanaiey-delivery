class HomeSubscriptionsServiceModel {
  dynamic subscriptionId;
  dynamic subscriptionName;
  dynamic description;
  dynamic departmentId;
  dynamic requestNumberPerMonth;
  dynamic startFromPrice;
  dynamic condition;
  dynamic priceCaption;
  dynamic startFromPriceC;


  HomeSubscriptionsServiceModel({
    this.subscriptionId,
    this.subscriptionName,
    this.description,
    this.departmentId,
    this.requestNumberPerMonth,
    this.startFromPrice,
    this.condition,
    this.priceCaption,
    this.startFromPriceC,
  });

  HomeSubscriptionsServiceModel.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscriptionId'];
    subscriptionName = json['subscriptionName'];
    description = json['description'];
    departmentId = json['departmentId'];
    requestNumberPerMonth = json['requestNumberPerMonth'];
    startFromPrice = json['startFromPrice'];
    condition = json['condition'];
    priceCaption = json['priceCaption'];
    startFromPriceC = json['startFromPriceC'];
  }
}