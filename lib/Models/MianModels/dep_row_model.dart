class DepartmentRowModel {
  dynamic departmentName;
  dynamic departmentSub0;
  dynamic departmentSub0Id;
  dynamic departmentId;
  dynamic department;
  dynamic departmentSub1T;

  DepartmentRowModel({
    this.departmentName,
    this.departmentSub0,
    this.departmentSub0Id,
    this.departmentId,
    this.department,
    this.departmentSub1T,
  });

  DepartmentRowModel.fromJson(Map<String, dynamic> json) {
    departmentName = json['departmentName'];
    departmentSub0 = json['departmentSub0'];
    departmentSub0Id = json['departmentSub0Id'];
    departmentId = json['departmentId'];
    department = json['department'];
    departmentSub1T = json['departmentSub1T'];
  }
}
