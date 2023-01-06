
import 'package:flutter/material.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';

class OrderNumber extends StatelessWidget {
  const OrderNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const CustomText(text: "طلب 12345#"),
      ],
    );
  }
}
