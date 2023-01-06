class PointsModel {
  dynamic clientPointId;
  dynamic clientId;
  dynamic points;
  dynamic pointType;
  dynamic reason;
  dynamic creationDate;
  dynamic systemUserId;
  dynamic client;

  PointsModel({
    this.clientPointId,
    this.clientId,
    this.points,
    this.pointType,
    this.reason,
    this.creationDate,
    this.systemUserId,
    this.client,
  });

  PointsModel.fromJson(Map<String, dynamic> json) {
    clientPointId = json['clientPointId'];
    clientId = json['clientId'];
    points = json['points'];
    pointType = json['pointType'];
    reason = json['reason'];
    creationDate = json['creationDate'];
    systemUserId = json['systemUserId'];
    client = json['client'];
  }
}
