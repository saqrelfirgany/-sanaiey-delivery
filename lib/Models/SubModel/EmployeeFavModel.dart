class EmployeeModel {
dynamic id;
dynamic name;
dynamic title;
dynamic rate;
dynamic isFavourite;
dynamic image;
dynamic employeeReviews;

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
    employeeReviews = json['employeeReviews'];
  }
}