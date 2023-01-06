
import 'package:flutter/material.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';

class TopText extends StatelessWidget {
  const TopText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomSizedBox(
          percentageOfHeight: .01,
        ),
        CustomText(text: "اختر مزود الخدمة", fontWeight: FontWeight.bold),
        CustomSizedBox(
          percentageOfHeight: .01,
        ),
        CustomText(text: "تمت مطابقة طلبك مع مزودي الخدمة الانسب لك ")
      ],
    );
  }
}
