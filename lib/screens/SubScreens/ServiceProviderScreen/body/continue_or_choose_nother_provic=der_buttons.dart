
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class ContinueButtonOrChooseAnotherProviderButtons extends StatelessWidget {
  const ContinueButtonOrChooseAnotherProviderButtons({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * .9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              child: const Center(
                child: CustomText(
                    text: "متابعة الطلب",
                    percentageOfHeight: .02,
                    textColor: whiteColor),
              ),
              height: isLandscape(context)
                  ? 2 * height(context) * .06
                  : height(context) * .06,
              width: width(context) * .5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: secondaryColor),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              child: const Center(
                child: CustomText(
                    text: "مقدم خدمة اخر",
                    percentageOfHeight: .02,
                    textColor: mainColor),
              ),
              height: isLandscape(context)
                  ? 2 * height(context) * .06
                  : height(context) * .06,
              width: width(context) * .38,
              decoration: BoxDecoration(
                  border: Border.all(color: mainColor),
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
