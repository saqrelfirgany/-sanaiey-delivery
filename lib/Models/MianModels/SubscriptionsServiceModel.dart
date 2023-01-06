class SubscriptionsServiceModel {
  dynamic serviceName;
  dynamic serviceDescription;
  dynamic totalPrice;
  dynamic netPrice;
  dynamic subscriptionServiceId;

  SubscriptionsServiceModel({
    this.serviceName,
    this.serviceDescription,
    this.totalPrice,
    this.netPrice,
    this.subscriptionServiceId,
  });

  SubscriptionsServiceModel.fromJson(Map<String, dynamic> json) {
    serviceName = json['serviceName'];
    serviceDescription = json['serviceDescription'];
    totalPrice = json['totalPrice'];
    netPrice = json['netPrice'];
    subscriptionServiceId = json['subscriptionServiceId'];
  }
}
