class RegionModel {
  dynamic regionId;
  dynamic regionName;
  dynamic deliveryPrice;
  dynamic isDeliveryPriceActive;
  dynamic minimumCharge;
  dynamic isMinimumChargeActive;
  dynamic locationLat;
  dynamic locationLang;
  dynamic locationUrl;
  dynamic cityId;
  dynamic city;
  dynamic addressT;

  RegionModel({
    this.regionId,
    this.regionName,
    this.deliveryPrice,
    this.isDeliveryPriceActive,
    this.minimumCharge,
    this.isMinimumChargeActive,
    this.locationLat,
    this.locationLang,
    this.locationUrl,
    this.cityId,
    this.city,
    this.addressT,
  });

  RegionModel.fromJson(Map<String, dynamic> json) {
    regionId = json['regionId'];
    regionName = json['regionName'];
    deliveryPrice = json['deliveryPrice'];
    isDeliveryPriceActive = json['isDeliveryPriceActive'];
    minimumCharge = json['minimumCharge'];
    isMinimumChargeActive = json['isMinimumChargeActive'];
    locationLat = json['locationLat'];
    locationLang = json['locationLang'];
    locationUrl = json['locationUrl'];
    cityId = json['cityId'];
    city = json['city'];
  }
}
