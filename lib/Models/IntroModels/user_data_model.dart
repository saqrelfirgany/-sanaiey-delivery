class UserDataModel {
  dynamic clientId;
  dynamic clientName;
  dynamic currentAddress;
  dynamic currentPhone;
  dynamic clientEmail;
  dynamic clientRegDate;
  dynamic clientNotes;
  dynamic clientKnowUs;
  dynamic branchId;
  dynamic systemUserId;
  dynamic clientPoints;
  dynamic branch;
  dynamic systemUser;
  List<ClientPhonesT>? clientPhonesT;

  UserDataModel({
    this.clientId,
    this.clientName,
    this.currentAddress,
    this.currentPhone,
    this.clientEmail,
    this.clientRegDate,
    this.clientNotes,
    this.clientKnowUs,
    this.branchId,
    this.systemUserId,
    this.clientPoints,
    this.branch,
    this.systemUser,
    this.clientPhonesT,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    clientId = json['clientId'];
    clientName = json['clientName'];
    currentAddress = json['currentAddress'];
    currentPhone = json['currentPhone'];
    clientEmail = json['clientEmail'];
    clientRegDate = json['clientRegDate'];
    clientNotes = json['clientNotes'];
    clientKnowUs = json['clientKnowUs'];
    branchId = json['branchId'];
    systemUserId = json['systemUserId'];
    clientPoints = json['clientPoints'];
    branch = json['branch'];
    systemUser = json['systemUser'];
    if (json['clientPhonesT'] != null) {
      clientPhonesT = <ClientPhonesT>[];
      json['clientPhonesT'].forEach((v) {
        clientPhonesT!.add(ClientPhonesT.fromJson(v));
      });
    }
  }
}

class ClientPhonesT {
  dynamic clientPhoneId;
  dynamic clientId;
  dynamic clientPhone;
  dynamic pwdUsr;
  dynamic code;
  dynamic active;
  dynamic isDefault;

  ClientPhonesT({
    this.clientPhoneId,
    this.clientId,
    this.clientPhone,
    this.pwdUsr,
    this.code,
    this.active,
    this.isDefault,
  });

  ClientPhonesT.fromJson(Map<String, dynamic> json) {
    clientPhoneId = json['clientPhoneId'];
    clientId = json['clientId'];
    clientPhone = json['clientPhone'];
    pwdUsr = json['pwdUsr'];
    code = json['code'];
    active = json['active'];
    isDefault = json['isDefault'];
  }
}