
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/constants/spacing_and_sizes.dart';
import 'package:sanaiey/custom_widgets/custom_icon_button.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/screens/MainScreens/OrderScreens/service_provider_details/service_provider_details_screen.dart';
import 'package:sanaiey/utils/responsive.dart';

class SingleServiceProviderCard extends StatelessWidget {
  const SingleServiceProviderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: listViewVerticalSpacing * height(context)),
          child: GestureDetector(
            onTap: () {
              fadNavigate(context, ServiceProviderDetailsScreen());
            },
            child: Neumorphic(
              child: Container(
                padding: EdgeInsets.only(
                  right: defaultCardPadding * width(context),
                  left: defaultCardPadding * width(context),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width(context) * .4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomSizedBox(percentageOfHeight: .02),
                          const CustomText(text: "احمد محمد"),
                          const CustomSizedBox(percentageOfHeight: .01),
                          const CustomText(
                            text: "سباك",
                          ),
                          const CustomSizedBox(percentageOfHeight: .01),
                          Row(children: [
                            Icon(Icons.star,
                                color: mainColor,
                                size: isLandscape(context) ? 2 * height(context) * .03 : height(context) * .03),
                            Icon(Icons.star,
                                color: mainColor,
                                size: isLandscape(context) ? 2 * height(context) * .03 : height(context) * .03),
                            Icon(Icons.star,
                                color: mainColor,
                                size: isLandscape(context) ? 2 * height(context) * .03 : height(context) * .03),
                            Icon(Icons.star,
                                color: mainColor,
                                size: isLandscape(context) ? 2 * height(context) * .03 : height(context) * .03),
                            Icon(Icons.star,
                                color: mainColor,
                                size: isLandscape(context) ? 2 * height(context) * .03 : height(context) * .03),
                          ]),
                          const CustomSizedBox(percentageOfHeight: .01),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: isLandscape(context) ? 2 * height(context) * .12 : height(context) * .12,
                          width: width(context) * .18,
                          decoration: BoxDecoration(
                              color: secondaryColor,
                              border: Border.all(color: mainColor, width: 5),
                              shape: BoxShape.circle),
                        ),
                        Container(
                          height: isLandscape(context) ? 2 * height(context) * .14 : height(context) * .14,
                          child: CustomIconButton(
                              onTap: () {}, size: defaultIconSize, color: secondaryColor, icon: Icons.favorite),
                          alignment: Alignment.topCenter,
                        )
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(color: backGroundColor, borderRadius: BorderRadius.circular(8)),
                height: isLandscape(context) ? 2 * height(context) * .15 : height(context) * .15,
                width: width(context) * .9,
              ),
            ),
          ),
        )
      ],
    );
  }
}
