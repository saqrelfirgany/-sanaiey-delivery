
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_icon_button.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class ChooseDayWidget extends StatelessWidget {
  const ChooseDayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: const Center(
              child: CustomText(
                text: "الثلاثاء 23 11 2021",
                textColor: greyColor,
              ),
            ),
            height: isLandscape(context)
                ? 2 * height(context) * .07
                : height(context) * .07,
            width: width(context) * .69,
            decoration: BoxDecoration(
                color: backGroundColor,
                borderRadius: BorderRadius.circular(10)),
          ),
          Container(
            child: const CustomIconButton(
                color: mainColor, icon: Icons.date_range),
            height: isLandscape(context)
                ? 2 * height(context) * .07
                : height(context) * .07,
            width: width(context) * .2,
            decoration: BoxDecoration(
                color: backGroundColor,
                borderRadius: BorderRadius.circular(10)),
          )
        ],
      ),
    );
  }
}
