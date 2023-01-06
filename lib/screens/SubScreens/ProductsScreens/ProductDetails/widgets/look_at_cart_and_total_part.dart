
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class LookAtCartAndTotalPartInProductDetails extends StatelessWidget {
  const LookAtCartAndTotalPartInProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width(context),
        height: isLandscape(context)
            ? 2 * height(context) * .08
            : height(context) * .08,
        color: mainColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: width(context) * .2,
              height: isLandscape(context)
                  ? 2 * height(context) * .06
                  : height(context) * .06,
              decoration: BoxDecoration(
                  border: Border.all(color: whiteColor, width: 2),
                  shape: BoxShape.circle),
              child: const Center(
                child: CustomText(
                  text: "2",
                  textColor: whiteColor,
                ),
              ),
            ),
            const CustomText(
              text: "انظر سلة المنتجات",
              textColor: whiteColor,
              decoration: TextDecoration.underline,
            ),
            const CustomText(
              text: "الإجمالى 100 ج ",
              textColor: whiteColor,
            ),
          ],
        ));
  }
}
