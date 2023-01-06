class OrderDetailsTrackingModel {
  List<RequestTrackItemList>? requestTrackItemList;
  SelectedEmployee? selectedEmployee;
  dynamic selectedTrackId;
  dynamic isReqestCanceled;

  OrderDetailsTrackingModel({
    this.requestTrackItemList,
    this.selectedEmployee,
    this.selectedTrackId,
    this.isReqestCanceled,
  });

  OrderDetailsTrackingModel.fromJson(Map<String, dynamic> json) {
    if (json['requestTrackItemList'] != null) {
      requestTrackItemList = <RequestTrackItemList>[];
      json['requestTrackItemList'].forEach((v) {
        requestTrackItemList!.add(new RequestTrackItemList.fromJson(v));
      });
    }
    selectedEmployee =
        json['selectedEmployee'] != null ? new SelectedEmployee.fromJson(json['selectedEmployee']) : null;
    selectedTrackId = json['selectedTrackId'];
    isReqestCanceled = json['isReqestCanceled'];
  }
}

class RequestTrackItemList {
  dynamic id;
  dynamic name;
  dynamic imageURL;
  dynamic actionTime;
  dynamic showEmployee;
  dynamic showReview;
  dynamic showCompliment;

  RequestTrackItemList({
    this.id,
    this.name,
    this.imageURL,
    this.actionTime,
    this.showEmployee,
    this.showReview,
    this.showCompliment,
  });

  RequestTrackItemList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageURL = json['imageURL'];
    actionTime = json['actionTime'];
    showEmployee = json['showEmployee'];
    showReview = json['showReview'];
    showCompliment = json['showCompliment'];
  }
}

class SelectedEmployee {
  dynamic id;
  dynamic name;
  dynamic departmentId;
  dynamic title;
  dynamic rate;
  dynamic isFavourite;
  dynamic image;
  dynamic phone;
  dynamic showCalendar;
  dynamic showContact;
  dynamic employeeReviews;

  SelectedEmployee({
    this.id,
    this.name,
    this.departmentId,
    this.title,
    this.rate,
    this.isFavourite,
    this.image,
    this.phone,
    this.showCalendar,
    this.showContact,
    this.employeeReviews,
  });

  SelectedEmployee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    departmentId = json['departmentId'];
    title = json['title'];
    rate = json['rate'];
    isFavourite = json['isFavourite'];
    image = json['image'];
    phone = json['phone'];
    showCalendar = json['showCalendar'];
    showContact = json['showContact'];
    employeeReviews = json['employeeReviews'];
  }
}
