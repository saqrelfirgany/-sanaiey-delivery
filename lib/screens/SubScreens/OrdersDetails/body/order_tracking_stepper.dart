import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_icon_button.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

import 'order_tracking_dots.dart';

class OrderTrackingStepper extends StatelessWidget {
  final bool isStepCompleted;
  final String stepImagePath;

  const OrderTrackingStepper({
    this.isStepCompleted: false,
    this.stepImagePath: "",
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: isLandscape(context) ? 2 * height * .4 : height * .4,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * .15,
                height: isLandscape(context) ? 2 * height * .1 : height * .1,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/icons/delivered.png"))),
              ),
              Container(
                width: width * .15,
                height: isLandscape(context) ? 2 * height * .1 : height * .1,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/icons/recieved.png"))),
              ),
              Container(
                width: width * .15,
                height: isLandscape(context) ? 2 * height * .1 : height * .1,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/icons/happy.png"))),
              ),
            ],
          ),
          SizedBox(width: width * .03),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomSizedBox(
                percentageOfHeight: .02,
              ),
              Container(
                decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: mainColor, width: 1),
                    shape: BoxShape.circle),
                width: width * .065,
                height: isLandscape(context) ? 2 * height * .05 : height * .05,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: isStepCompleted ? mainColor : mainColor,
                        border: Border.all(color: mainColor, width: 2),
                        shape: BoxShape.circle),
                    width: width * .05,
                    height: isLandscape(context) ? 2 * height * .05 : height * .05,
                  ),
                ),
              ),
              const OrderTrackingDots(),
              Container(
                decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: mainColor, width: 1),
                    shape: BoxShape.circle),
                width: width * .065,
                height: isLandscape(context) ? 2 * height * .05 : height * .05,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: isStepCompleted ? mainColor : whiteColor,
                        border: Border.all(color: mainColor, width: 2),
                        shape: BoxShape.circle),
                    width: width * .05,
                    height: isLandscape(context) ? 2 * height * .05 : height * .05,
                  ),
                ),
              ),
              const OrderTrackingDots(),
              Container(
                decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: mainColor, width: 1),
                    shape: BoxShape.circle),
                width: width * .065,
                height: isLandscape(context) ? 2 * height * .05 : height * .05,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: isStepCompleted ? mainColor : whiteColor,
                        border: Border.all(color: mainColor, width: 2),
                        shape: BoxShape.circle),
                    width: width * .05,
                    height: isLandscape(context) ? 2 * height * .05 : height * .05,
                  ),
                ),
              ),
              const CustomSizedBox(
                percentageOfHeight: .02,
              ),
            ],
          ),
          SizedBox(width: width * .03),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomSizedBox(
                percentageOfHeight: .001,
              ),
              Column(
                children: [
                  SizedBox(
                    width: width * .6,
                    child: const CustomText(
                      text: "تم استلام الطلب",
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.bold,
                      percentageOfHeight: .02,
                      textColor: blackColor,
                    ),
                  ),
                  const CustomSizedBox(
                    percentageOfHeight: .02,
                  ),
                  SizedBox(
                    width: width * .6,
                    child: Row(
                      children: [
                        CustomIconButton(icon: Icons.av_timer, onTap: () {}, color: blackColor, size: .02),
                        const CustomText(
                          text: "9:10 AM , 9 May 2021",
                          textColor: greyColor,
                          percentageOfHeight: .015,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const CustomSizedBox(percentageOfHeight: .05),
              Column(
                children: [
                  SizedBox(
                    width: width * .6,
                    child: const CustomText(
                      text: "تم التلقي والفني في طريقه إليك",
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.bold,
                      percentageOfHeight: .02,
                      textColor: blackColor,
                    ),
                  ),
                  const CustomSizedBox(
                    percentageOfHeight: .02,
                  ),
                  SizedBox(
                    width: width * .6,
                    child: Row(
                      children: [
                        CustomIconButton(icon: Icons.av_timer, onTap: () {}, color: blackColor, size: .02),
                        const CustomText(
                          text: "9:10 AM , 9 May 2021",
                          textColor: greyColor,
                          percentageOfHeight: .015,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const CustomSizedBox(percentageOfHeight: .05),
              Column(
                children: [
                  SizedBox(
                    width: width * .6,
                    child: const CustomText(
                      text: "سعدنا بخدمتك",
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.bold,
                      percentageOfHeight: .02,
                      textColor: blackColor,
                    ),
                  ),
                  const CustomSizedBox(
                    percentageOfHeight: .02,
                  ),
                  SizedBox(
                    width: width * .6,
                    child: Row(
                      children: [
                        CustomIconButton(icon: Icons.av_timer, onTap: () {}, color: blackColor, size: .02),
                        const CustomText(
                          text: "9:10 AM , 9 May 2021",
                          textColor: greyColor,
                          percentageOfHeight: .015,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const CustomSizedBox(
                percentageOfHeight: .001,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
