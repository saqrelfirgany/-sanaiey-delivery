
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/screens/SubScreens/OrdersDetails/body/single_bill_item.dart';

class BillDetailsData extends StatelessWidget {
  const BillDetailsData({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            CustomText(
                text: "تفاصيل الفاتورة",
                fontWeight: FontWeight.bold,
                textColor: blackColor,)
          ],
        ),
        const CustomSizedBox(
          percentageOfHeight: .02,
        ),
        const SingleBillItem(fieldName: "الحساب", fieldValue: "100"),
        const SingleBillItem(fieldName: "ضريبة", fieldValue: "100"),
        const SingleBillItem(fieldName: "الخصم", fieldValue: "100"),
        const SingleBillItem(fieldName: "نقاط", fieldValue: "100"),
        const SingleBillItem(
            fieldName: "المجموع الكي", fieldValue: "100", isTotal: true),
      ],
    );
  }
}
