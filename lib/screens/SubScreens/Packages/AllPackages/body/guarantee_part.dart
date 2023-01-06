import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/screens/SubScreens/Packages/AllPackages/body/single_guarantee_item.dart';

class GuaranteePart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: 180.h,
      padding: EdgeInsets.all(8.w),
      color: Color(0xFF00000029),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding:
                      EdgeInsets.only(right: width * .05, left: width * .05),
                  child: CustomText(
                    text: "نحن نضمن",
                    textColor: blackColor,
                  )),
            ],
          ),
          CustomSizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding:
                      EdgeInsets.only(right: width * .05, left: width * .05),
                  child: Container(
                    height: 1,
                    width: width * .2,
                    color: blackColor,
                  )),
            ],
          ),
          CustomSizedBox(),
          SingleGuaranteeItem(
            titleText: "ضمان علي الخدمة",
            descriptionText: "حتي 30 يوم من تاريخ إنتهاء الخدمة",
            imagePath: "assets/icons/30_guarantee.png",
          ),
          CustomSizedBox(
            percentageOfHeight: .02,
          ),
          SingleGuaranteeItem(
            titleText: "مزودي خدمات معتمدين",
            descriptionText: "حتي 30 يوم من تاريخ إنتهاء الخدمة",
            imagePath: "assets/icons/signed.png",
          ),
          CustomSizedBox(
            percentageOfHeight: .02,
          ),
          SingleGuaranteeItem(
              titleText: "مركز خدمة العملاء",
              descriptionText: "حتي 30 يوم من تاريخ إنتهاء الخدمة",
              imagePath: "assets/icons/support_center.png")
        ],
      ),
    );
  }
}
