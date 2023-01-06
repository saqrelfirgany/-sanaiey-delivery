class AddressModel {
  dynamic addressId;
  dynamic clientId;
  dynamic governorateId;
  dynamic cityId;
  dynamic regionId;
  dynamic addressGov;
  dynamic addressCity;
  dynamic addressRegion;
  dynamic addressStreet;
  dynamic addressBlockNum;
  dynamic addressFlatNum;
  dynamic addressDes;
  dynamic location;
  dynamic latitude;
  dynamic longitude;
  dynamic isDefault;
  dynamic client;
  dynamic region;
  dynamic city;
  dynamic requestT;

  AddressModel({
    this.addressId,
    this.clientId,
    this.governorateId,
    this.cityId,
    this.regionId,
    this.addressGov,
    this.addressCity,
    this.addressRegion,
    this.addressStreet,
    this.addressBlockNum,
    this.addressFlatNum,
    this.addressDes,
    this.location,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.client,
    this.region,
    this.city,
    this.requestT,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    addressId = json['addressId'];
    clientId = json['clientId'];
    governorateId = json['governorateId'];
    cityId = json['cityId'];
    regionId = json['regionId'];
    addressGov = json['addressGov'];
    addressCity = json['addressCity'];
    addressRegion = json['addressRegion'];
    addressStreet = json['addressStreet'];
    addressBlockNum = json['addressBlockNum'];
    addressFlatNum = json['addressFlatNum'];
    addressDes = json['addressDes'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefault = json['isDefault'] ?? false;
    client = json['client'];
    region = json['region'];
    city = json['city'];
  }
}
