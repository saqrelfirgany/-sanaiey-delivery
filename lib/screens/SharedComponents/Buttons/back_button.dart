import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/IntroControllers/auth_controller.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';

class AuthBack extends StatelessWidget {
  const AuthBack({Key? key, required this.text, this.width = 90, this.height = 50}) : super(key: key);
  final String text;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) => controller.loading || controller.loadingVerification
          ? Container()
          : GetBuilder<UserController>(
              builder: (userController) => userController.loading
                  ? Container()
                  : InkWell(
                      onTap: () => Navigator.pop(context),
                      child: GetShadow(
                        child: Container(
                          width: width.w,
                          height: height.h,
                          decoration: decorationRadiusBorder(color: mainColor),
                          child: Center(
                            child: Text(
                              text.tr,
                              style: titleNormal(
                                color: mainColor,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
    );
  }
}
