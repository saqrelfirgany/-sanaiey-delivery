
import 'package:flutter/cupertino.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

import 'dots_for_bill_details.dart';

class SingleBillItem extends StatelessWidget {
  final String fieldValue, fieldName;
  final bool isTotal;
  const SingleBillItem(
      {this.fieldValue: "", this.fieldName: "", this.isTotal: false});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
        bottom: isLandscape(context) ? 2 * height * .02 : height * .02,
      ),
      width: width * .9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              text: fieldName,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          const DotsForBillDetails(),
          CustomText(
              text: "$fieldValue ج ",
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)
        ],
      ),
    );
  }
}
