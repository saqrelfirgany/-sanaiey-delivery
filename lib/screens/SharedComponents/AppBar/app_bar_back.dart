import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_icon_button.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class HomeAppBarWithBack extends StatelessWidget {
  const HomeAppBarWithBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: EdgeInsets.only(
                top: isLandscape(context)
                    ? 2 * height(context) * .03
                    : height(context) * .03,
                right: width(context) * .03,
                left: width(context) * .03),
            color: mainColor,
            height: isLandscape(context)
                ? 2 * height(context) * .12
                : height(context) * .12,
            width: width(context),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomIconButton(
                      onTap: () {
//                  customPushNamedNavigation(context, AppCurvedBar()) ;
                      },
                      icon: Icons.notifications_outlined),
                  SizedBox(),
                  Row(
                    children: [
                      CustomIconButton(
                        onTap: () => Navigator.pop(context),
                        icon: Icons.arrow_forward_ios,
                        // size: 10.w,
                      ),
                    ],
                  ),
                ],
              ),
            )),
        Container(
          padding: EdgeInsets.only(
              top: isLandscape(context)
                  ? 2 * height(context) * .11
                  : height(context) * .11,
              right: width(context) * .04,
              left: width(context) * .04),
          height: isLandscape(context)
              ? 2 * height(context) * .16
              : height(context) * .16,
          width: width(context),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
//                navigate to location screen
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(20)),
                  height: isLandscape(context)
                      ? 2 * height(context) * .025
                      : height(context) * .025,
                  width: width(context) * .43,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back_ios,
                          color: whiteColor,
                          size: isLandscape(context)
                              ? 2 * height(context) * .015
                              : height(context) * .015),
                      SizedBox(
                        width: width(context) * .01,
                      ),
                      SizedBox(
                          child: const CustomText(
                              text: "Mase el gededa Roxy",
                              maxLines: 1,
                              percentageOfHeight: .010,
                              textColor: whiteColor),
                          width: width(context) * .25),
                      SizedBox(
                        width: width(context) * .01,
                      ),
                      Icon(Icons.my_location,
                          color: whiteColor,
                          size: isLandscape(context)
                              ? 2 * height(context) * .015
                              : height(context) * .015),
                    ],
                  )),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              top: isLandscape(context)
                  ? 2 * height(context) * .038
                  : height(context) * .038,
              right: width(context) * .05,
              left: width(context) * .05),
          height: isLandscape(context)
              ? 2 * height(context) * .16
              : height(context) * .16,
          width: width(context),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/logo.png"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
