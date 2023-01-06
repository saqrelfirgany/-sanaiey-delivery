
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/constants/spacing_and_sizes.dart';
import 'package:sanaiey/custom_widgets/custom_icon_button.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class FavProviderItem extends StatelessWidget {
  final String imagePath;

  const FavProviderItem({Key? key, this.imagePath = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: listViewVerticalSpacing * height(context)),
          child: Neumorphic(
            style: NeumorphicStyle(
                depth: 1,
                lightSource: LightSource.topLeft,
                shadowDarkColor: blackColor,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10))),
            child: Container(
              padding: EdgeInsets.only(
                right: defaultCardPadding * width(context),
                left: defaultCardPadding * width(context),
              ),
              child: Column(
                children: [
                  const CustomSizedBox(percentageOfHeight: .03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                          percentageOfHeight: .015,
                          textColor: blackColor,
                          textAlign: TextAlign.start,
                          text: "صيانة نجفة",
                          fontWeight: FontWeight.bold),
                      CustomIconButton(
                        onTap: () {},
                        size: defaultIconSize,
                        color: secondaryColor,
                        icon: Icons.favorite,
                      )
                    ],
                  ),
                  const CustomSizedBox(percentageOfHeight: .0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width(context) * .8,
                        child: const CustomText(
                            percentageOfHeight: .014,
                            textColor: greyColor,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            text: "تركيب 2 نجفة من غير تجمع",
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox()
                    ],
                  ),
                  const CustomSizedBox(percentageOfHeight: .0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CustomText(
                              percentageOfHeight: .013,
                              textColor: greyColor,
                              textAlign: TextAlign.start,
                              text: "ج",
                              fontWeight: FontWeight.bold),
                          const CustomText(
                              percentageOfHeight: .013,
                              textColor: greyColor,
                              textAlign: TextAlign.start,
                              text: "100",
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: const Center(
                            child:
                                CustomText(text: "أضف إلى العربة", percentageOfHeight: .015, textColor: whiteColor),
                          ),
                          height: isLandscape(context) ? 2 * height(context) * .03 : height(context) * .03,
                          width: width(context) * .28,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(defaultButtonRadius), color: mainColor),
                        ),
                      ),
                    ],
                  ),
                  const CustomSizedBox(percentageOfHeight: .03),
                ],
              ),
              decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(8)),
//              height: isLandscape(context)
//                  ? 2 * height(context) * .15
//                  : height(context) * .15,
              width: width(context) * .9,
            ),
          ),
        )
      ],
    );
  }
}
