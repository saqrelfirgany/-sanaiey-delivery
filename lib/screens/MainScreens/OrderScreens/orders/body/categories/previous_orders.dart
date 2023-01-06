import 'package:flutter/material.dart';
import 'package:sanaiey/Models/MianModels/order_model.dart';
import 'package:sanaiey/utils/responsive.dart';

import '../order_item.dart';

class PreviousOrders extends StatelessWidget {
  const PreviousOrders({Key? key}) : super(key: key);

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
            borderColor: Colors.green,
            buttonColor: Colors.green,
            buttonText: "تم التنفيذ",
            orderItem: OrderModel(),
          );
        },
      ),
    );
  }
}
