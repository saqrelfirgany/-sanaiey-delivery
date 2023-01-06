class EmployeeModel {
  dynamic id;
  dynamic name;
  dynamic title;
  dynamic rate;
  dynamic isFavourite;
  dynamic image;
  List<EmployeeReviews>? employeeReviews;

  EmployeeModel(
      {this.id,
        this.name,
        this.title,
        this.rate,
        this.isFavourite,
        this.image,
        this.employeeReviews,});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    rate = json['rate'];
    isFavourite = json['isFavourite'];
    image = json['image'];
    if (json['employeeReviews'] != null) {
      employeeReviews = <EmployeeReviews>[];
      json['employeeReviews'].forEach((v) {
        employeeReviews!.add(new EmployeeReviews.fromJson(v));
      });
    }
  }
}

class EmployeeReviews {
  dynamic requestId;
  dynamic clientId;
  dynamic clientName;
  dynamic review;
  dynamic rate;
  dynamic creationTime;

  EmployeeReviews(
      {this.requestId,
        this.clientId,
        this.clientName,
        this.review,
        this.rate,
        this.creationTime,});

  EmployeeReviews.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    clientId = json['clientId'];
    clientName = json['clientName'];
    review = json['review'];
    rate = json['rate'];
    creationTime = json['creationTime'];
  }

}