
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_icon_button.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class ServiceProviderDetailsWidget extends StatelessWidget {
  const ServiceProviderDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          right: width(context) * .05, left: width(context) * .05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSizedBox(percentageOfHeight: .02),
              const CustomIconButton(
                  icon: Icons.favorite_border, color: secondaryColor),
              const CustomText(text: "احمد محمد"),
              const CustomSizedBox(percentageOfHeight: .01),
              const CustomText(
                text: "سباك",
              ),
              const CustomSizedBox(percentageOfHeight: .01),
              Row(children: [
                Icon(Icons.star,
                    color: mainColor,
                    size: isLandscape(context)
                        ? 2 * height(context) * 0.02
                        : height(context) * 0.02),
                Icon(Icons.star,
                    color: mainColor,
                    size: isLandscape(context)
                        ? 2 * height(context) * 0.02
                        : height(context) * 0.02),
                Icon(Icons.star,
                    color: mainColor,
                    size: isLandscape(context)
                        ? 2 * height(context) * 0.02
                        : height(context) * 0.02),
                Icon(Icons.star,
                    color: mainColor,
                    size: isLandscape(context)
                        ? 2 * height(context) * 0.02
                        : height(context) * 0.02),
                Icon(Icons.star,
                    color: mainColor,
                    size: isLandscape(context)
                        ? 2 * height(context) * 0.02
                        : height(context) * 0.02),
              ]),
              const CustomSizedBox(percentageOfHeight: .01),
            ],
          ),
          Container(
            height: isLandscape(context)
                ? 2 * height(context) * .12
                : height(context) * .12,
            width: width(context) * .25,
            decoration: BoxDecoration(
                color: backGroundColor,
                border: Border.all(color: mainColor, width: 2),
                shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}
