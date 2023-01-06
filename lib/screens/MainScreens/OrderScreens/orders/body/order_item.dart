import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/Models/MianModels/order_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/constants/font_sizes.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/screens/SubScreens/OrdersDetails/orders_details.dart';
import 'package:sanaiey/utils/responsive.dart';

orderItem({
  BuildContext? context,
  Color buttonColor = mainColor,
  String buttonText = "",
  Color borderColor = mainColor,
  required OrderModel orderItem,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          Get.find<OrderController>().setOrderDetailsId(id: '${orderItem.requestId}');
          fadNavigate(context, const OrdersDetailsScreen());
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: Container(
              decoration: BoxDecoration(
                color: backGroundColor,
                border: Border.all(color: borderColor, width: 2),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    offset: const Offset(0, 0),
                    blurRadius: 4.0,
                  )
                ],
              ),
              height: isLandscape(context!) ? 2 * height(context) * .25 : height(context) * .25,
              width: width(context) * .85,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: whiteColor,
                              size:
                                  isLandscape(context) ? 2 * height(context) * .03 : height(context) * .03,
                            ),
                            SizedBox(
                              width: width(context) * .02,
                            ),
                            CustomText(
                              textColor: whiteColor,
                              text: "${orderItem.requestStatus}",
                            )
                          ],
                        ),
                        width: width(context) * .85,
                        height: isLandscape(context) ? 2 * height(context) * .05 : height(context) * .05,
                        decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8))),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(right: width(context) * .01, left: width(context) * .01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CustomSizedBox(percentageOfHeight: .02),
                        CustomText(
                          text: "${orderItem.requestCaption}",
                          percentageOfHeight: defaultFontSize,
                          textColor: mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                        const Divider(thickness: 1, color: greyColor),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: width(context) * .38,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomSizedBox(percentageOfHeight: .005),
                                  CustomText(
                                      text: "${orderItem.department}",
                                      fontWeight: FontWeight.bold,
                                      percentageOfHeight: defaultFontSize),
                                  CustomSizedBox(percentageOfHeight: .009),
                                  CustomText(
                                    text: "${orderItem.services}",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    percentageOfHeight: .017,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width(context) * .01,
                            ),
                            SizedBox(
                              height:
                                  isLandscape(context) ? 2 * height(context) * .08 : height(context) * .08,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 4,
                                    width: 1,
                                    color: mainColor,
                                  ),
                                  Container(
                                    height: 4,
                                    width: 1,
                                    color: mainColor,
                                  ),
                                  Container(
                                    height: 4,
                                    width: 1,
                                    color: mainColor,
                                  ),
                                  Container(
                                    height: 4,
                                    width: 1,
                                    color: mainColor,
                                  ),
                                  Container(
                                    height: 4,
                                    width: 1,
                                    color: mainColor,
                                  ),
                                  Container(
                                    height: 4,
                                    width: 1,
                                    color: mainColor,
                                  ),
                                  Container(
                                    height: 4,
                                    width: 1,
                                    color: mainColor,
                                  ),
                                  Container(
                                    height: 4,
                                    width: 1,
                                    color: mainColor,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width(context) * .01,
                            ),
                            SizedBox(
                              width: width(context) * .38,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const CustomSizedBox(percentageOfHeight: .005),
                                  CustomText(
                                      text: "${orderItem.dayOfWeek}",
                                      fontWeight: FontWeight.bold,
                                      // textAlign:,
                                      textColor: secondaryColor),
                                  const CustomSizedBox(percentageOfHeight: .005),
                                  CustomText(
                                    text: "${orderItem.date}",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                  ),
                                  const CustomSizedBox(percentageOfHeight: .005),
                                  CustomText(
                                    text: "${orderItem.time}",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                  ),
                                  const CustomSizedBox(percentageOfHeight: .01),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      child: const Center(
                                        child: CustomText(text: "التفاصيل", textColor: whiteColor),
                                      ),
                                      height: isLandscape(context)
                                          ? 2 * height(context) * .03
                                          : height(context) * .03,
                                      width: width(context) * .2,
                                      decoration: BoxDecoration(
                                          color: secondaryColor, borderRadius: BorderRadius.circular(5)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
      )
    ],
  );
}
