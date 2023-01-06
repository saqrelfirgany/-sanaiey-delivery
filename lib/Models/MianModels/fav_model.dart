class FavModel {
  dynamic isInCart;
  dynamic cartQuantity;
  dynamic isFavourite;
  dynamic hasDiscount;
  dynamic netServiceCost;
  dynamic serviceId;
  dynamic serviceName;
  dynamic departmentId;
  dynamic serviceCost;
  dynamic serviceDuration;
  dynamic serviceDes;
  dynamic materialCost;
  dynamic servicePoints;
  dynamic noDiscount;
  dynamic serviceDiscount;
  dynamic discountServiceCount;
  dynamic companyDiscountPercentage;
  dynamic department;
  dynamic cartDetailsT;
  dynamic requestServicesT;

  FavModel({
    this.isInCart,
    this.cartQuantity,
    this.isFavourite,
    this.hasDiscount,
    this.netServiceCost,
    this.serviceId,
    this.serviceName,
    this.departmentId,
    this.serviceCost,
    this.serviceDuration,
    this.serviceDes,
    this.materialCost,
    this.servicePoints,
    this.noDiscount,
    this.serviceDiscount,
    this.discountServiceCount,
    this.companyDiscountPercentage,
    this.department,
    this.cartDetailsT,
    this.requestServicesT,
  });

  FavModel.fromJson(Map<String, dynamic> json) {
    isInCart = json['isInCart'];
    cartQuantity = json['cartQuantity'];
    isFavourite = json['isFavourite'];
    hasDiscount = json['hasDiscount'];
    netServiceCost = json['netServiceCost'];
    serviceId = json['serviceId'];
    serviceName = json['serviceName'];
    departmentId = json['departmentId'];
    serviceCost = json['serviceCost'];
    serviceDuration = json['serviceDuration'];
    serviceDes = json['serviceDes'];
    materialCost = json['materialCost'];
    servicePoints = json['servicePoints'];
    noDiscount = json['noDiscount'];
    serviceDiscount = json['serviceDiscount'];
    discountServiceCount = json['discountServiceCount'];
    companyDiscountPercentage = json['companyDiscountPercentage'];
    department = json['department'];
  }
}
