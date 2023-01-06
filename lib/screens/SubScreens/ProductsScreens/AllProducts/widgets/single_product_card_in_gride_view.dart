
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/constants/spacing_and_sizes.dart';
import 'package:sanaiey/custom_widgets/custom_icon_button.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/screens/SubScreens/ProductsScreens/ProductDetails/product_details_screen.dart';
import 'package:sanaiey/utils/responsive.dart';

class SingleProductInGridView extends StatelessWidget {
  const SingleProductInGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            fadNavigate(context, ProductDetailsScreen());
          },
          child: Neumorphic(
            child: Container(
              child: Column(
                children: [
                  const CustomSizedBox(percentageOfHeight: .01),
                  Neumorphic(
                    child: Container(
                      decoration: const BoxDecoration(color: backGroundColor),
                      width: width(context) * .35,
                      height: isLandscape(context) ? 2 * height(context) * .12 : height(context) * .12,
                    ),
                  ),
                  const CustomSizedBox(percentageOfHeight: .01),
                  Container(
                    padding: EdgeInsets.only(
                        right: width(context) * defaultCardPadding, left: width(context) * defaultCardPadding),
                    width: width(context) * .4,
                    child: const CustomText(
                        textColor: blackColor,
                        text: "اسم المنتج",
                        textAlign: TextAlign.start,
                        percentageOfHeight: .015),
                  ),
                  const CustomSizedBox(percentageOfHeight: .005),
                  Container(
                    padding: EdgeInsets.only(
                        right: width(context) * defaultCardPadding, left: width(context) * defaultCardPadding),
                    width: width(context) * .4,
                    child: const CustomText(
                        text: "تفاصيل أخرى مصغرة", textAlign: TextAlign.start, percentageOfHeight: .013),
                  ),
                  const CustomSizedBox(percentageOfHeight: .005),
                  Row(
                    children: [
                      SizedBox(
                        width: defaultCardPadding * width(context),
                      ),
                      const CustomText(
                          text: "100", textAlign: TextAlign.start, percentageOfHeight: .014, textColor: blackColor),
                      const CustomText(
                          text: "ج", textAlign: TextAlign.start, percentageOfHeight: .014, textColor: blackColor),
                      SizedBox(
                        width: 0.02 * width(context),
                      ),
                      const CustomText(
                          text: "150",
                          textAlign: TextAlign.start,
                          percentageOfHeight: .015,
                          textColor: greyColor,
                          decoration: TextDecoration.lineThrough),
                      SizedBox(
                        width: 0.01 * width(context),
                      ),
                      const CustomText(
                          text: "ج", textAlign: TextAlign.start, percentageOfHeight: .015, textColor: greyColor)
                    ],
                  ),
                  const CustomSizedBox(percentageOfHeight: .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: const Center(
                            child:
                                CustomText(text: "أضف إلى العربة", percentageOfHeight: .015, textColor: whiteColor),
                          ),
                          height: isLandscape(context) ? 2 * height(context) * .03 : height(context) * .03,
                          width: width(context) * .3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(defaultButtonRadius), color: mainColor),
                        ),
                      ),
                      CustomIconButton(
                          onTap: () {}, size: defaultIconSize, color: secondaryColor, icon: Icons.favorite)
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(8)),
              height: isLandscape(context) ? 2 * height(context) * .28 : height(context) * .28,
              width: width(context) * .4,
            ),
          ),
        )
      ],
    );
  }
}
