import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Models/SubModel/order_details_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/cart_controller.dart';
import 'package:sanaiey/screens/MainScreens/SubscriptionsScreen/body/fav_service_item.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/loader.dart';

import '../../../../controllers/MainControllers/order_controller.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({
    Key? key,
    required this.cartItem,
    required this.orderController,
    required this.requestId,
  }) : super(key: key);
  final RequestServiceList cartItem;
  final String requestId;
  final OrderController orderController;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _updating = false;
  bool _deleting = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            height: 100.h,
            // width: 384.w,
            margin: EdgeInsetsDirectional.only(
              start: 16.w,
              end: 16.w,
              top: 8.h,
            ),
            padding: EdgeInsetsDirectional.all(8.w),
            decoration: decorationRadiusBorder(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 186.w,
                          child: Text(
                            '${widget.cartItem.serviceName}',
                            maxLines: 1,
                            style: titleBold(color: Colors.black, size: 13),
                          ),
                        ),
                        SizedBox(
                          width: 186.w,
                          child: Text(
                            '${widget.cartItem.serviceDescription ?? ''}',
                            maxLines: 1,
                            style: titleNormal(color: Colors.grey.shade700, size: 12),
                          ),
                        ),
                        SizedBox(
                          width: 186.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.cartItem.netPrice} ج',
                                maxLines: 1,
                                style: titleNormal(color: Colors.grey.shade700, size: 12).copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '${widget.cartItem.netPrice} ج',
                                maxLines: 1,
                                style: titleNormal(color: Colors.red.shade900, size: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(width: 36.w),
                    DotsCart(),
                    SizedBox(width: 4.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _deleting
                            ? SizedBox(
                                width: 52.w,
                                height: 30.h,
                              )
                            : _updating
                                ? SizedBox(
                                    width: 91.w,
                                    height: 30.h,
                                    child: Loader(),
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
                                                Get.find<OrderController>().setRequestId(
                                                  id: widget.requestId,
                                                );
                                                setState(() {
                                                  _updating = true;
                                                });

                                                int quantity = int.parse('${widget.cartItem.quantity}') + 1;
                                                var isAdded = await widget.orderController
                                                    .updateOrderFromOrderDetails(
                                                  serviceId: '${widget.cartItem.serviceId}',
                                                  serviceQuantity: '$quantity',
                                                );
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
                                            child: Center(
                                              child: Text(
                                                '${widget.cartItem.quantity}',
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
                                                Get.find<OrderController>().setRequestId(
                                                  id: widget.requestId,
                                                );
                                                setState(() {
                                                  _updating = true;
                                                });
                                                await Future.delayed(Duration(seconds: 1));
                                                if (widget.cartItem.quantity == 1) {
                                                  int quantity = 0;
                                                  var isAdded = await widget.orderController
                                                      .updateOrderFromOrderDetails(
                                                    serviceId: '${widget.cartItem.serviceId}',
                                                    serviceQuantity: '$quantity',
                                                  );
                                                  setState(() {
                                                    _updating = false;
                                                  });
                                                  return;
                                                }
                                                int quantity = int.parse('${widget.cartItem.quantity}') - 1;
                                                var isAdded = await widget.orderController
                                                    .updateOrderFromOrderDetails(
                                                  serviceId: '${widget.cartItem.serviceId}',
                                                  serviceQuantity: '$quantity',
                                                );
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
                                  ),
                        SizedBox(width: 4.w),
                        _updating
                            ? SizedBox(
                                width: 52.w,
                                height: 30.h,
                              )
                            : _deleting
                                ? SizedBox(
                                    width: 91.w,
                                    height: 30.h,
                                    child: SpinKitFadingCircle(
                                      size: 30.w,
                                      color: mainColor,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () async {
                                      Get.find<OrderController>().setRequestId(
                                        id: widget.requestId,
                                      );
                                      setState(() {
                                        _deleting = true;
                                      });
                                      int quantity = 0;
                                      var isAdded =
                                          await widget.orderController.updateOrderFromOrderDetails(
                                        serviceId: '${widget.cartItem.serviceId}',
                                        serviceQuantity: '$quantity',
                                      );
                                      setState(() {
                                        _deleting = false;
                                      });
                                    },
                                    icon: Icon(
                                      CupertinoIcons.delete,
                                      color: const Color(0xFF00385B),
                                      size: 20.w,
                                    ),
                                  ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DotsCart extends StatelessWidget {
  const DotsCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 2.w,
      // color: Colors.blue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Spacer(),
          Container(
            height: 8.h,
            width: 1.w,
            color: Colors.grey.shade700,
          ),
          SizedBox(height: 4.h),
          Container(
            height: 8.h,
            width: 1.w,
            color: Colors.grey.shade700,
          ),
          SizedBox(height: 4.h),
          Container(
            height: 8.h,
            width: 1.w,
            color: Colors.grey.shade700,
          ),
          SizedBox(height: 4.h),
          Container(
            height: 8.h,
            width: 1.w,
            color: Colors.grey.shade700,
          ),
          SizedBox(height: 4.h),
          Container(
            height: 8.h,
            width: 1.w,
            color: Colors.grey.shade700,
          ),
          // SizedBox(height: 4.h),
          // Container(
          //   height: 8.h,
          //   width: 1.w,
          //   color: Colors.grey.shade700,
          // ),
          // SizedBox(height: 4.h),
          // Container(
          //   height: 8.h,
          //   width: 1.w,
          //   color: Colors.grey.shade700,
          // ),
          Spacer(),
        ],
      ),
    );
  }
}
