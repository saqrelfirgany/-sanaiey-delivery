import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/controllers/IntroControllers/auth_controller.dart';

import '../loader.dart';

class AuthButton extends StatelessWidget {
  AuthButton({
    Key? key,
    required this.press,
    required this.text,
    this.width = 230,
    this.height = 50,
    this.padding = 80,
  }) : super(key: key);
  VoidCallback press;
  final String text;
  final double width;
  final double height;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) => controller.loadingVerification
          ? Container()
          : controller.loading
              ? Container(
                  margin: EdgeInsetsDirectional.only(start: padding.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        // width: width.w,
                        height: height.h,
                        child: loader,
                      ),
                    ],
                  ),
                )
              : InkWell(
                  onTap: press,
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(10.r),
                    child: Container(
                      width: width.w,
                      height: height.h,
                      // margin: EdgeInsets.all(16.w),
                      decoration: decorationRadius().copyWith(
                        color: const Color(0xFFAE0910),
                      ),
                      child: Center(
                        child: Text(
                          text.tr,
                          style: titleNormal(
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
