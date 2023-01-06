class UserSubscriptionsModel {
  dynamic clientSubscriptionId;
  dynamic subscriptionServiceId;
  dynamic subscriptionId;
  dynamic subscriptionName;
  dynamic imageUrl;
  dynamic serviceName;
  dynamic visitCountDescription;
  dynamic description;
  dynamic address;
  dynamic phone;
  dynamic visitTime;
  dynamic departmentId;

  UserSubscriptionsModel({
    this.clientSubscriptionId,
    this.subscriptionServiceId,
    this.subscriptionId,
    this.subscriptionName,
    this.imageUrl,
    this.serviceName,
    this.visitCountDescription,
    this.description,
    this.address,
    this.phone,
    this.visitTime,
    this.departmentId,
  });

  UserSubscriptionsModel.fromJson(Map<String, dynamic> json) {
    clientSubscriptionId = json['clientSubscriptionId'];
    subscriptionServiceId = json['subscriptionServiceId'];
    subscriptionId = json['subscriptionId'];
    subscriptionName = json['subscriptionName'];
    imageUrl = json['imageUrl'];
    serviceName = json['serviceName'];
    visitCountDescription = json['visitCountDescription'];
    description = json['description'];
    address = json['address'];
    phone = json['phone'];
    visitTime = json['visitTime'];
    departmentId = json['departmentId'];
  }
}