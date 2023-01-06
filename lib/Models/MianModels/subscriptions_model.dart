class SubscriptionsModel {
  dynamic subscriptionId;
  dynamic subscriptionName;
  dynamic description;
  dynamic departmentId;
  dynamic startFromPriceC;
  dynamic specification;

  SubscriptionsModel({
    this.subscriptionId,
    this.subscriptionName,
    this.description,
    this.departmentId,
    this.startFromPriceC,
    this.specification,
  });

  SubscriptionsModel.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscriptionId'];
    subscriptionName = json['subscriptionName'];
    description = json['description'];
    departmentId = json['departmentId'];
    startFromPriceC = json['startFromPriceC'];
    specification = json['specification'];
  }
}
