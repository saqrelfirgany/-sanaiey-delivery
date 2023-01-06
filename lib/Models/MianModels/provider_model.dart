class ProviderModel {
  dynamic id;
  dynamic name;
  dynamic title;
  dynamic rate;
  dynamic isFavourite;
  dynamic image;
  dynamic employeeReviews;
  dynamic phone;
  dynamic showCalendar;
  dynamic showContact;

  ProviderModel({
  this.id,
    this.name,
    this.title,
    this.rate,
    this.isFavourite,
    this.image,
    this.employeeReviews,
    this.phone,
    this.showCalendar,
    this.showContact,
  });

  ProviderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    rate = json['rate'];
    isFavourite = json['isFavourite'];
    image = json['image'];
    employeeReviews = json['employeeReviews'];
    phone = json['phone'];
    showCalendar = json['showCalendar'];
    showContact = json['showContact'];
  }
}

List<ProviderModel> providerList = [

];
