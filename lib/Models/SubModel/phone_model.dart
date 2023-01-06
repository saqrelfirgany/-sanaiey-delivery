class PhoneModel {
  dynamic clientPhoneId;
  dynamic clientId;
  dynamic clientPhone;
  dynamic pwdUsr;
  dynamic code;
  dynamic active;
  dynamic isDefault;
  dynamic client;
  dynamic requestT;

  PhoneModel({
    this.clientPhoneId,
    this.clientId,
    this.clientPhone,
    this.pwdUsr,
    this.code,
    this.active,
    this.isDefault,
    this.client,
    this.requestT,
  });

  PhoneModel.fromJson(Map<String, dynamic> json) {
    clientPhoneId = json['clientPhoneId'];
    clientId = json['clientId'];
    clientPhone = json['clientPhone'];
    pwdUsr = json['pwdUsr'];
    code = json['code'];
    active = json['active'];
    isDefault = json['isDefault'];
    client = json['client'];
    requestT = json['requestT'];
  }
}
