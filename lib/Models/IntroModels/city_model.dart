class City {
  dynamic cityId;
  dynamic branchId;
  dynamic cityName;
  dynamic deliveryPrice;
  dynamic minimumCharge;
  dynamic loactionLat;
  dynamic locationLang;
  dynamic locationUrl;
  dynamic governorateId;
  dynamic branch;

  City({
    this.cityId,
    this.branchId,
    this.cityName,
    this.deliveryPrice,
    this.minimumCharge,
    this.loactionLat,
    this.locationLang,
    this.locationUrl,
    this.governorateId,
    this.branch,
  });

  City.fromJson(Map<String, dynamic> json) {
    cityId = json['cityId'];
    branchId = json['branchId'];
    cityName = json['cityName'];
    deliveryPrice = json['deliveryPrice'];
    minimumCharge = json['minimumCharge'];
    loactionLat = json['loactionLat'];
    locationLang = json['locationLang'];
    locationUrl = json['locationUrl'];
    governorateId = json['governorateId'];
    branch = json['branch'];
  }
}
