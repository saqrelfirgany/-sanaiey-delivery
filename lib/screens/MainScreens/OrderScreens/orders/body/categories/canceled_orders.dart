import 'package:flutter/material.dart';
import 'package:sanaiey/Models/MianModels/order_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/utils/responsive.dart';

import '../order_item.dart';

class CanceledOrders extends StatelessWidget {
  const CanceledOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isLandscape(context) ? 2 * height(context) * .67 : height(context) * .67,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemCount: 1,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return orderItem(
            context: context,
            borderColor: secondaryColor,
            buttonColor: secondaryColor,
            buttonText: "حالة الطلب ملغاة",
            orderItem: OrderModel(),
          );
        },
      ),
    );
  }
}
