class OrderDetailsModel {
  dynamic requestId;
  dynamic requestCaption;
  dynamic date;
  dynamic dayOfWeek;
  dynamic time;
  dynamic requestStatus;
  dynamic cityName;
  dynamic regionName;
  dynamic streetName;
  dynamic location;
  dynamic longitude;
  dynamic latitude;
  dynamic phone;
  dynamic invoiceDetails;
  dynamic departmentId;
  dynamic departmentName;
  dynamic flatNumber;
  dynamic floorNumber;
  dynamic showAddServiceButton;
  dynamic showCancelRequestButton;
  dynamic showDelayRequestButton;
  dynamic showReAssignEmployeeButton;
  Employee? employee;
  List<RequestServiceList>? requestServiceList;

  OrderDetailsModel({
    this.requestId,
    this.requestCaption,
    this.date,
    this.dayOfWeek,
    this.time,
    this.requestStatus,
    this.cityName,
    this.regionName,
    this.streetName,
    this.location,
    this.longitude,
    this.latitude,
    this.phone,
    this.invoiceDetails,
    this.employee,
    this.departmentId,
    this.departmentName,
    this.requestServiceList,
    this.flatNumber,
    this.floorNumber,
    this.showAddServiceButton,
    this.showCancelRequestButton,
    this.showDelayRequestButton,
    this.showReAssignEmployeeButton,
  });

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    requestCaption = json['requestCaption'];
    date = json['date'];
    dayOfWeek = json['dayOfWeek'];
    time = json['time'];
    requestStatus = json['requestStatus'];
    cityName = json['cityName'];
    regionName = json['regionName'];
    streetName = json['streetName'];
    location = json['location'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    phone = json['phone'];
    invoiceDetails = json['invoiceDetails'];
    departmentId = json['departmentId'];
    departmentName = json['departmentName'];
    flatNumber = json['flatNumber'];
    floorNumber = json['floorNumber'];
    showAddServiceButton = json['showAddServiceButton'];
    showCancelRequestButton = json['showCancelRequestButton'];
    showDelayRequestButton = json['showDelayRequestButton'];
    showReAssignEmployeeButton = json['showReAssignEmployeeButton'];
    if (json['employee'] != null) {
      employee = Employee.fromJson(json['employee']);
    }
    if (json['requestServiceList'] != null) {
      requestServiceList = <RequestServiceList>[];
      json['requestServiceList'].forEach((v) {
        requestServiceList!.add(new RequestServiceList.fromJson(v));
      });
    }
  }
}

class Employee {
  dynamic id;
  dynamic name;
  dynamic title;
  dynamic isFavourite;
  dynamic rate;
  dynamic image;

  Employee({
    this.id,
    this.name,
    this.title,
    this.isFavourite,
    this.rate,
    this.image,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    isFavourite = json['isFavourite'];
    rate = json['rate'];
    image = json['image'];
  }
}

class RequestServiceList {
  dynamic requestServiceId;
  dynamic serviceId;
  dynamic serviceName;
  dynamic serviceDescription;
  dynamic quantity;
  dynamic netPrice;

  RequestServiceList({
    this.requestServiceId,
    this.serviceId,
    this.serviceName,
    this.serviceDescription,
    this.quantity,
    this.netPrice,
  });

  RequestServiceList.fromJson(Map<String, dynamic> json) {
    requestServiceId = json['requestServiceId'];
    serviceId = json['serviceId'];
    serviceName = json['serviceName'];
    serviceDescription = json['serviceDescription'];
    quantity = json['quantity'];
    netPrice = json['netPrice'];
  }
}
