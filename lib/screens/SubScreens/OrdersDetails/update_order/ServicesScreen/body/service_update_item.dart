import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Models/MianModels/offer_item_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/cart_controller.dart';
import 'package:sanaiey/controllers/MainControllers/fav_controller.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';

class ServiceUpdateCard extends StatefulWidget {
  const ServiceUpdateCard({Key? key, required this.item, required this.index}) : super(key: key);
  final OfferItemModel item;
  final int index;

  @override
  State<ServiceUpdateCard> createState() => _ServiceUpdateCardState();
}

class _ServiceUpdateCardState extends State<ServiceUpdateCard> {
  bool _updating = false;
  late FavController favController;
  late CartController cartController;
  late OrderController orderController;

  @override
  void initState() {
    super.initState();
    favController = Get.find<FavController>();
    cartController = Get.find<CartController>();
    orderController = Get.find<OrderController>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 3,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          height: 92.h,
          width: 370.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            // border: Border.all(width: 1, color: Colors.grey.shade400),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.8),
            //     offset: const Offset(0, 0),
            //     blurRadius: 8.0,
            //   )
            // ],
          ),
          // margin: ,
          padding: EdgeInsetsDirectional.all(8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 260.w,
                    child: Text(
                      '${widget.item.serviceName}',
                      maxLines: 1,
                      style: titleBold(color: Colors.black, size: 13),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (widget.item.isFavourite) {
                        setState(() {
                          widget.item.isFavourite = false;
                        });
                        favController.addToFav(serviceId: '${widget.item.serviceId}');
                      } else {
                        setState(() {
                          widget.item.isFavourite = true;
                        });
                        favController.addToFav(serviceId: '${widget.item.serviceId}');
                      }
                    },
                    child: widget.item.isFavourite
                        ? Icon(CupertinoIcons.heart_fill, color: Colors.red.shade900)
                        : Icon(CupertinoIcons.heart, color: Colors.red.shade900),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 260.w,
                        child: Text(
                          '${widget.item.serviceDes}',
                          style: titleNormal(color: Colors.grey.shade700, size: 12),
                        ),
                      ),
                      SizedBox(
                        width: 260.w,
                        child: widget.item.hasDiscount
                            ? Row(
                                children: [
                                  Text(
                                    '${widget.item.serviceCost} ج',
                                    style: titleNormal(color: Colors.grey.shade700, size: 12).copyWith(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    '${widget.item.netServiceCost} ج',
                                    maxLines: 1,
                                    style: titleNormal(color: Colors.red.shade900, size: 12),
                                  ),
                                ],
                              )
                            : Text(
                                '${widget.item.serviceCost} ج',
                                style: titleNormal(color: Colors.red.shade900, size: 12),
                              ),
                      ),
                    ],
                  ),
                  _updating
                      ? SizedBox(
                          width: 91.w,
                          height: 30.h,
                          child: SpinKitFadingCircle(
                            size: 30.w,
                            color: mainColor,
                          ),
                        )
                      : Container(
                          width: 91.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(26.r),
                            border: Border.all(color: Color(0xFF00385B)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  width: 28.w,
                                  height: 30.h,
                                  alignment: Alignment.topCenter,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.only(
                                      topStart: Radius.circular(26.r),
                                      bottomStart: Radius.circular(26.r),
                                    ),
                                    color: const Color(0xFF00385B),
                                  ),
                                  child: IconButton(
                                    alignment: Alignment.topCenter,
                                    onPressed: () async {
                                      setState(() {
                                        _updating = true;
                                      });
                                      var isAdded = await orderController.addServiceToOrderDetails(
                                        serviceId: '${widget.item.serviceId}',
                                        serviceQuantity: '${widget.item.cartQuantity + 1}',
                                      );
                                      if (isAdded) {
                                        setState(() {
                                          widget.item.cartQuantity = widget.item.cartQuantity + 1;
                                        });
                                      }
                                      setState(() {
                                        _updating = false;
                                      });
                                    },
                                    icon: Icon(
                                      CupertinoIcons.plus,
                                      color: Colors.white,
                                      size: 12.h,
                                    ),
                                  ),
                                ),
                              ),

                              ///
                              /// Divider
                              ///
                              const CartDivider(),
                              Expanded(
                                child: Container(
                                  width: 28.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${widget.item.cartQuantity}',
                                      style: cairoW600(
                                        color: Colors.grey.shade900,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              ///
                              /// Divider
                              ///
                              const CartDivider(),
                              Expanded(
                                child: Container(
                                  width: 28.w,
                                  height: 30.h,
                                  alignment: Alignment.topCenter,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.only(
                                      topEnd: Radius.circular(26.r),
                                      bottomEnd: Radius.circular(26.r),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: IconButton(
                                    alignment: Alignment.topCenter,
                                    onPressed: () async {
                                      if (widget.item.cartQuantity == 0) return;
                                      setState(() {
                                        _updating = true;
                                      });
                                      if (widget.item.cartQuantity == 1) {
                                        var removed = await orderController.addServiceToOrderDetails(
                                          serviceId: '${widget.item.serviceId}',
                                          serviceQuantity: '0',
                                        );
                                        if (removed == true) {
                                          setState(() {
                                            widget.item.cartQuantity = 0;
                                            _updating = false;
                                          });
                                        }
                                        return;
                                      }
                                      var isAdded =await orderController.addServiceToOrderDetails(
                                        serviceId: '${widget.item.serviceId}',
                                        serviceQuantity: '${widget.item.cartQuantity - 1}',
                                      );
                                      if (isAdded) {
                                        setState(() {
                                          widget.item.cartQuantity = widget.item.cartQuantity - 1;
                                        });
                                      }
                                      setState(() {
                                        _updating = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                      size: 12.h,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 4.w),
                            ],
                          ),
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartDivider extends StatelessWidget {
  const CartDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2.w,
      height: 30.h,
      color: Colors.grey.withOpacity(0.3),
    );
  }
}
