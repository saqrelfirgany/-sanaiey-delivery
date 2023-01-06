
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/utils/responsive.dart';

import 'custom_network_indicator.dart';

class CustomBuildBody extends StatelessWidget {
  final String headerTitle;
  final bool withCustomHeader;
  final Widget customHeader;
  final Widget buildBodyWidget;
  bool withPadding;
  bool isSalespointsScreen;
  Color backgroundColor;

  CustomBuildBody(
      {this.withCustomHeader: false,
      this.customHeader: const SizedBox(),
      this.backgroundColor: whiteColor,
      this.isSalespointsScreen: false,
      this.withPadding: true,
      this.headerTitle: "",
      this.buildBodyWidget: const SizedBox()});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        extendBody: true,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                child: withCustomHeader == true
                    ? customHeader
                    : Stack(
                        clipBehavior: Clip.none,
                        // overflow: Overflow.visible,
                        children: [
                          Container(
                              padding: EdgeInsets.only(
                                  top: isLandscape(context) ? 2 * height(context) * .03 : height(context) * .03,
                                  right: width(context) * .03,
                                  left: width(context) * .03),
                              color: mainColor,
                              height: isLandscape(context) ? 2 * height(context) * .14 : height(context) * .14,
                              width: width(context),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.notifications,
                                          color: whiteColor,
                                          size: isLandscape(context)
                                              ? 2 * height(context) * .04
                                              : height(context) * .04,
                                        )),
                                    SizedBox(),
                                    GestureDetector(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.search,
                                          color: whiteColor,
                                          size: isLandscape(context)
                                              ? 2 * height(context) * .04
                                              : height(context) * .04,
                                        )),
                                  ],
                                ),
                              )),
                          Container(
                              padding: EdgeInsets.only(
                                  top: isLandscape(context) ? 2 * height(context) * .05 : height(context) * .05,
                                  right: width(context) * .05,
                                  left: width(context) * .05),
                              height: isLandscape(context) ? 2 * height(context) * .18 : height(context) * .18,
                              width: width(context),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(image: AssetImage("assets/icons/logo.png"))),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
              ),
              // SizedBox(height: 40),
              SizedBox(
                height: isLandscape(context) ? 2 * height(context) * .84 : height(context) * .84,
                child: NetworkIndicator(
                  child: Container(
                    padding: EdgeInsets.only(
                        right: withPadding == true ? width(context) * .05 : 0,
                        left: withPadding == true ? width(context) * .05 : 0),
                    child: buildBodyWidget,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
