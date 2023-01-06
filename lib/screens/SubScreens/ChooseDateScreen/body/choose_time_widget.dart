
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class ChooseTimeWidget extends StatelessWidget {
  const ChooseTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomSizedBox(percentageOfHeight: .01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: const Center(
                child: CustomText(
                  text: "4:30 م - 5:30 م",
                  textColor: greyColor,
                ),
              ),
              height: isLandscape(context)
                  ? 2 * height(context) * .07
                  : height(context) * .07,
              width: width(context) * .44,
              decoration: BoxDecoration(
                  color: backGroundColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
            Container(
              child: const Center(
                child: CustomText(
                  text: "4:30 م - 5:30 م",
                  textColor: whiteColor,
                ),
              ),
              height: isLandscape(context)
                  ? 2 * height(context) * .07
                  : height(context) * .07,
              width: width(context) * .44,
              decoration: BoxDecoration(
                  color: mainColor, borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ),
        const CustomSizedBox(percentageOfHeight: .01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: const Center(
                child: CustomText(
                  text: "4:30 م - 5:30 م",
                  textColor: greyColor,
                ),
              ),
              height: isLandscape(context)
                  ? 2 * height(context) * .07
                  : height(context) * .07,
              width: width(context) * .44,
              decoration: BoxDecoration(
                  color: backGroundColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
            Container(
              child: const Center(
                child: CustomText(
                  text: "4:30 م - 5:30 م",
                  textColor: greyColor,
                ),
              ),
              height: isLandscape(context)
                  ? 2 * height(context) * .07
                  : height(context) * .07,
              width: width(context) * .44,
              decoration: BoxDecoration(
                  color: backGroundColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ),
        const CustomSizedBox(percentageOfHeight: .01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: const Center(
                child: CustomText(
                  text: "4:30 م - 5:30 م",
                  textColor: greyColor,
                ),
              ),
              height: isLandscape(context)
                  ? 2 * height(context) * .07
                  : height(context) * .07,
              width: width(context) * .44,
              decoration: BoxDecoration(
                  color: backGroundColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
            Container(
              child: const Center(
                child: CustomText(
                  text: "4:30 م - 5:30 م",
                  textColor: greyColor,
                ),
              ),
              height: isLandscape(context)
                  ? 2 * height(context) * .07
                  : height(context) * .07,
              width: width(context) * .44,
              decoration: BoxDecoration(
                  color: backGroundColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ),
        const CustomSizedBox(percentageOfHeight: .01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: const Center(
                child: CustomText(
                  text: "4:30 م - 5:30 م",
                  textColor: greyColor,
                ),
              ),
              height: isLandscape(context)
                  ? 2 * height(context) * .07
                  : height(context) * .07,
              width: width(context) * .44,
              decoration: BoxDecoration(
                  color: backGroundColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
            Container(
              child: const Center(
                child: CustomText(
                  text: "4:30 م - 5:30 م",
                  textColor: greyColor,
                ),
              ),
              height: isLandscape(context)
                  ? 2 * height(context) * .07
                  : height(context) * .07,
              width: width(context) * .44,
              decoration: BoxDecoration(
                  color: backGroundColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ),
      ],
    );
  }
}
