class OrdersStatusModel {
  dynamic id;
  dynamic statusName;


  OrdersStatusModel({
    this.id,
    this.statusName,

  });

  OrdersStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusName = json['statusName'];

  }
}
