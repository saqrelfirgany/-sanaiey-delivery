class Governorate {
  dynamic governorateId;
  dynamic governorateName;
  dynamic locationLat;
  dynamic locationLang;
  dynamic locationUrl;
  dynamic countryId;
  dynamic country;
  dynamic cityT;

  Governorate({
    this.governorateId,
    this.governorateName,
    this.locationLat,
    this.locationLang,
    this.locationUrl,
    this.countryId,
    this.country,
    this.cityT,
  });

  Governorate.fromJson(Map<String, dynamic> json) {
    governorateId = json['governorateId'];
    governorateName = json['governorateName'];
    locationLat = json['locationLat'];
    locationLang = json['locationLang'];
    locationUrl = json['locationUrl'];
    countryId = json['countryId'];
    country = json['country'];
    cityT = json['cityT'];
  }
}
