
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/constants/font_sizes.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/screens/SubScreens/Packages/PackageMoreDetails/package_more_details.dart';
import 'package:sanaiey/utils/responsive.dart';

class MonthlySubscriptionDescriptionCard extends StatelessWidget {
  const   MonthlySubscriptionDescriptionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            fadNavigate(context, PackageMoreDetails());
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Neumorphic(
              child: Container(
                  decoration: BoxDecoration(color: backGroundColor, borderRadius: BorderRadius.circular(5)),
                  width: width(context) * .85,
                  child: Container(
                    padding: EdgeInsets.only(right: width(context) * .01, left: width(context) * .01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CustomSizedBox(
                          percentageOfHeight: .02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: width(context) * .38,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  CustomSizedBox(percentageOfHeight: .005),
                                  CustomText(
                                      text: "2 زيارة شهريا",
                                      fontWeight: FontWeight.bold,
                                      percentageOfHeight: defaultFontSize),
                                  CustomSizedBox(
                                    percentageOfHeight: .01,
                                  ),
                                  CustomText(
                                      text: "مساحة منزل من 80-120 متر", maxLines: 2, textAlign: TextAlign.start),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width(context) * .01,
                            ),
                            SizedBox(
                              width: width(context) * .01,
                            ),
                            Container(
                              width: width(context) * .38,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomSizedBox(percentageOfHeight: .005),
                                  const CustomSizedBox(percentageOfHeight: .005),
                                  const CustomText(
                                      text: "450 ج",
                                      maxLines: 2,
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeight.bold),
                                  const CustomSizedBox(
                                    percentageOfHeight: .01,
                                  ),
                                  const CustomSizedBox(percentageOfHeight: .01),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      child: const Center(
                                        child: CustomText(text: "اضف للسلة", textColor: whiteColor),
                                      ),
                                      height:
                                          isLandscape(context) ? 2 * height(context) * .03 : height(context) * .03,
                                      width: width(context) * .2,
                                      decoration: BoxDecoration(
                                          color: secondaryColor, borderRadius: BorderRadius.circular(5)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const CustomSizedBox(
                          percentageOfHeight: .02,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        )
      ],
    );
  }
}
