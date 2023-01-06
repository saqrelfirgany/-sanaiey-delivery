class SettingsModel {
  dynamic settingId;
  dynamic settingKey;
  dynamic settingDatatype;
  dynamic settingValue;
  dynamic isAppSetting;
  dynamic creationDate;
  dynamic systemUserId;

  SettingsModel({
    this.settingId,
    this.settingKey,
    this.settingDatatype,
    this.settingValue,
    this.isAppSetting,
    this.creationDate,
    this.systemUserId,
  });

  SettingsModel.fromJson(Map<String, dynamic> json) {
    settingId = json['settingId'];
    settingKey = json['settingKey'];
    settingDatatype = json['settingDatatype'];
    settingValue = json['settingValue'];
    isAppSetting = json['isAppSetting'];
    creationDate = json['creationDate'];
    systemUserId = json['systemUserId'];
  }
}
