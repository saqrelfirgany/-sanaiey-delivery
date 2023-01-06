import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/utils/responsive.dart';

import '../order_item.dart';

class NewOrders extends StatelessWidget {
  const NewOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (orderController) =>  SizedBox(
        height: isLandscape(context) ? 2 * height(context) * .67 : height(context) * .67,
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 60.h),
          physics: const BouncingScrollPhysics(),
          itemCount: orderController.ordersDetailsList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return orderItem(
              context: context,
              borderColor: index.isEven ? mainColor : secondaryColor,
              buttonText: index.isOdd ? "قيد التنفيذ" : "تم استلام الطلب ",
              buttonColor: index.isOdd ? secondaryColor : mainColor,
              orderItem:orderController.ordersDetailsList[index],
            );
          },
        ),
      ),
    );
  }
}
