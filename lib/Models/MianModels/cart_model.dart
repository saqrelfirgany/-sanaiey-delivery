class CartModel {
  dynamic cartId;
  dynamic clientId;
  dynamic note;
  dynamic isPromoCodeApplied;
  dynamic promoCode;
  dynamic promoCodeDiscount;
  dynamic totalPrice;
  dynamic serviceDiscount;
  dynamic departmentDiscount;
  dynamic subscriptionDiscount;
  dynamic maxDiscountPercentage;
  dynamic maxDiscountPercentageDescription;
  dynamic applliedDiscount;
  dynamic totalPoints;
  dynamic pointsPerEGP;
  dynamic usePoints;
  dynamic usedPointsAmountInEGP;
  dynamic usedPoints;
  dynamic pointDescription;
  dynamic gainPointsDescription;
  dynamic netPrice;
  dynamic tax;
  dynamic minimumCharge;
  dynamic minimumChargeDescription;
  dynamic gainPoints;
  dynamic serviceRatio;
  dynamic cityId;
  dynamic departmentId;
  dynamic promocodeCompanyDiscountPercentage;
  dynamic companyDiscount;
  dynamic employeeDiscount;
  dynamic deliveryPrice;
  dynamic otherDiscount;
  List<CartServiceDetails>? cartServiceDetails;
  List<AttachmentModel>? attachmentList;
  dynamic discountDetails;
  dynamic invoiceDetails;

  CartModel({
    this.cartId,
    this.clientId,
    this.note,
    this.isPromoCodeApplied,
    this.promoCode,
    this.promoCodeDiscount,
    this.totalPrice,
    this.serviceDiscount,
    this.departmentDiscount,
    this.subscriptionDiscount,
    this.maxDiscountPercentage,
    this.maxDiscountPercentageDescription,
    this.applliedDiscount,
    this.totalPoints,
    this.pointsPerEGP,
    this.usePoints,
    this.usedPointsAmountInEGP,
    this.usedPoints,
    this.pointDescription,
    this.gainPointsDescription,
    this.netPrice,
    this.tax,
    this.minimumCharge,
    this.minimumChargeDescription,
    this.gainPoints,
    this.serviceRatio,
    this.cityId,
    this.departmentId,
    this.promocodeCompanyDiscountPercentage,
    this.companyDiscount,
    this.employeeDiscount,
    this.cartServiceDetails,
    this.deliveryPrice,
    this.otherDiscount,
    this.attachmentList,
    this.invoiceDetails,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    clientId = json['clientId'];
    note = json['note'];
    isPromoCodeApplied = json['isPromoCodeApplied'] ?? false;
    promoCode = json['promoCode'];
    promoCodeDiscount = json['promoCodeDiscount'];
    totalPrice = json['totalPrice'];
    serviceDiscount = json['serviceDiscount'];
    departmentDiscount = json['departmentDiscount'];
    subscriptionDiscount = json['subscriptionDiscount'];
    maxDiscountPercentage = json['maxDiscountPercentage'];
    maxDiscountPercentageDescription = json['maxDiscountPercentageDescription'];
    applliedDiscount = json['applliedDiscount'];
    totalPoints = json['totalPoints'];
    pointsPerEGP = json['pointsPerEGP'];
    usePoints = json['usePoints'];
    usedPointsAmountInEGP = json['usedPointsAmountInEGP'];
    usedPoints = json['usedPoints'];
    pointDescription = json['pointDescription'];
    gainPointsDescription = json['gainPointsDescription'];
    netPrice = json['netPrice'];
    tax = json['tax'];
    minimumCharge = json['minimumCharge'];
    minimumChargeDescription = json['minimumChargeDescription'];
    gainPoints = json['gainPoints'];
    serviceRatio = json['serviceRatio'];
    cityId = json['cityId'];
    departmentId = json['departmentId'];
    promocodeCompanyDiscountPercentage = json['promocodeCompanyDiscountPercentage'];
    companyDiscount = json['companyDiscount'];
    employeeDiscount = json['employeeDiscount'];
    deliveryPrice = json['deliveryPrice'];
    otherDiscount = json['otherDiscount'];
    discountDetails = json['discountDetails'];
    invoiceDetails = json['invoiceDetails'];
    if (json['cartServiceDetails'] != null) {
      cartServiceDetails = <CartServiceDetails>[];
      json['cartServiceDetails'].forEach((v) {
        cartServiceDetails!.add(new CartServiceDetails.fromJson(v));
      });
    }
    if (json['attachmentList'] != null) {
      attachmentList = <AttachmentModel>[];
      json['attachmentList'].forEach((v) {
        attachmentList!.add(new AttachmentModel.fromJson(v));
      });
    }
  }
}

class CartServiceDetails {
  dynamic serviceName;
  dynamic points;
  dynamic originalPrice;
  dynamic price;
  dynamic discount;
  dynamic netPrice;
  dynamic serviceDes;
  dynamic totalDiscount;
  dynamic totalPrice;
  dynamic totalNetPrice;
  dynamic cartDetailsId;
  dynamic cartId;
  dynamic serviceId;
  dynamic serviceQuantity;
  dynamic creationTime;
  dynamic cart;
  dynamic service;

  CartServiceDetails({
    this.serviceName,
    this.points,
    this.originalPrice,
    this.price,
    this.discount,
    this.netPrice,
    this.totalDiscount,
    this.totalPrice,
    this.serviceDes,
    this.totalNetPrice,
    this.cartDetailsId,
    this.cartId,
    this.serviceId,
    this.serviceQuantity,
    this.creationTime,
    this.cart,
    this.service,
  });

  CartServiceDetails.fromJson(Map<String, dynamic> json) {
    serviceName = json['serviceName'];
    points = json['points'];
    originalPrice = json['originalPrice'];
    price = json['price'];
    discount = json['discount'];
    netPrice = json['netPrice'];
    totalDiscount = json['totalDiscount'];
    totalPrice = json['totalPrice'];
    serviceDes = json['serviceDes'];
    totalNetPrice = json['totalNetPrice'];
    cartDetailsId = json['cartDetailsId'];
    cartId = json['cartId'];
    serviceId = json['serviceId'];
    serviceQuantity = json['serviceQuantity'];
    creationTime = json['creationTime'];
    cart = json['cart'];
    service = json['service'];
  }
}

class AttachmentModel {
  dynamic filePath;
  dynamic attachmentId;

  AttachmentModel({
    this.filePath,
    this.attachmentId,
  });

  AttachmentModel.fromJson(Map<String, dynamic> json) {
    filePath = json['filePath'];
    attachmentId = json['attachmentId'];
  }
}