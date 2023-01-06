class UserModel {
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

  UserModel({
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
  });

  UserModel.fromJson(Map<String, dynamic> json) {
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
    clientPoints = json['clientPoints'] ?? '0';
    branch = json['branch'];
    systemUser = json['systemUser'];
  }
}
