
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/constants/spacing_and_sizes.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class SingleServiceProviderRatingCard extends StatelessWidget {
  const SingleServiceProviderRatingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          right: width(context) * .05, left: width(context) * .05),
      margin:
          EdgeInsets.only(bottom: listViewVerticalSpacing * height(context)),
      child: Neumorphic(
        child: Container(
          padding: EdgeInsets.only(
              right: defaultCardPadding * width(context),
              left: defaultCardPadding * width(context)),
          width: width(context) * .9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: width(context) * .2,
                  child: const CustomText(
                    text: "جون عصمت",
                  )),
              Container(
                  padding: EdgeInsets.only(
                      right: defaultCardPadding * width(context),
                      left: defaultCardPadding * width(context)),
                  decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    children: [
                      const CustomSizedBox(
                        percentageOfHeight: .01,
                      ),
                      SizedBox(
                        child: const CustomText(
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          percentageOfHeight: .015,
                          text:
                              "ممتاز .. سرعة ودقة ممتاز .. سرعةودقةممتاز .. سرعة ودقة ممتاز .. سرعة ودقة",
                        ),
                        width: width(context) * .6,
                      ),
                      const CustomSizedBox(
                        percentageOfHeight: .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
                        ],
                      ),
                    ],
                  ),
                  width: width(context) * .6,
                  height: isLandscape(context)
                      ? 2 * height(context) * .08
                      : height(context) * .08)
            ],
          ),
          height: isLandscape(context)
              ? 2 * height(context) * .1
              : height(context) * .1,
          decoration: const BoxDecoration(
              color: backGroundColor,
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      ),
    );
  }
}
