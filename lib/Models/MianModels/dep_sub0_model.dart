class DepSub0Model {
  dynamic departmentId;
  dynamic departmentName;
  dynamic departmentSub0;
  dynamic departmentSub1;
  dynamic departmentDes;
  dynamic departmentSub0Id;
  dynamic departmentSub0Navigation;
  dynamic serviceT;

  DepSub0Model({
    this.departmentId,
    this.departmentName,
    this.departmentSub0,
    this.departmentSub1,
    this.departmentDes,
    this.departmentSub0Id,
    this.departmentSub0Navigation,
    this.serviceT,
  });

  DepSub0Model.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId'];
    departmentName = json['departmentName'];
    departmentSub0 = json['departmentSub0'];
    departmentSub1 = json['departmentSub1'];
    departmentDes = json['departmentDes'];
    departmentSub0Id = json['departmentSub0Id'];
    departmentSub0Navigation = json['departmentSub0Navigation'];
    serviceT = json['serviceT'];
  }
}
