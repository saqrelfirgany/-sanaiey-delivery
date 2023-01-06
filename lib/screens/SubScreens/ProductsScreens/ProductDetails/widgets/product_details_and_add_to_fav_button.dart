
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_icon_button.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class ProductDetailsAndAddToFavButton extends StatelessWidget {
  const ProductDetailsAndAddToFavButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width(context) * .9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: width(context) * .7,
                  child: const CustomText(
                      text: "اسم المنتج",
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      textColor: mainColor)),
              CustomIconButton(
                  icon: Icons.favorite, color: secondaryColor, onTap: () {})
            ],
          ),
        ),
        Container(
            width: width(context),
            padding: EdgeInsets.only(
                right: width(context) * .05, left: width(context) * .05),
            child: const CustomText(
              text: "تفاصيل أخرى مصغرة",
              textAlign: TextAlign.start,
              textColor: accentColor,
              maxLines: 500,
            )),
        const CustomSizedBox(
          percentageOfHeight: .01,
        ),
        SizedBox(
            width: width(context) * .9,
            child: Row(
              children: [
                const CustomText(
                  text: "50 ج",
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  textColor: blackColor,
                  fontWeight: FontWeight.bold,
                  percentageOfHeight: .025,
                ),
                SizedBox(width: width(context) * .02),
                const CustomText(
                  text: "70 ج",
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  percentageOfHeight: .015,
                  textColor: greyColor,
                  decoration: TextDecoration.lineThrough,
                ),
              ],
            )),
      ],
    );
  }
}
