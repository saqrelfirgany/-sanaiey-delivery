class DepartmentItemModel {
  dynamic id;
  dynamic itemId;
  dynamic departmentName;
  dynamic departmentId;
  dynamic description;
  dynamic department;
  dynamic imageUrl;
  dynamic item;
  dynamic isActive;
  dynamic dapartmentSub0Id;

  DepartmentItemModel({
    this.id,
    this.itemId,
    this.departmentName,
    this.departmentId,
    this.description,
    this.department,
    this.imageUrl,
    this.item,
    this.isActive,
    this.dapartmentSub0Id,
  });

  DepartmentItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['itemId'];
    departmentName = json['departmentName'];
    departmentId = json['departmentId'];
    description = json['description'];
    department = json['department'];
    imageUrl = json['imageUrl'];
    item = json['item'];
    isActive = json['isActive'];
    dapartmentSub0Id = json['dapartmentSub0Id'];
  }
}
