class Slider {
  dynamic itemId;
  dynamic itemType;
  dynamic imagePath;
  dynamic caption;
  dynamic departmentId;
  dynamic isActive;
  dynamic havePackage;
  dynamic landingScreenItemDetailsT;

  Slider({
    this.itemId,
    this.itemType,
    this.imagePath,
    this.caption,
    this.departmentId,
    this.isActive,
    this.havePackage,
    this.landingScreenItemDetailsT,
  });

  Slider.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemType = json['itemType'];
    imagePath = json['imagePath'];
    caption = json['caption'];
    departmentId = json['departmentId'];
    isActive = json['isActive'];
    havePackage = json['havePackage'];
    landingScreenItemDetailsT = json['landingScreenItemDetailsT'];
  }
}
