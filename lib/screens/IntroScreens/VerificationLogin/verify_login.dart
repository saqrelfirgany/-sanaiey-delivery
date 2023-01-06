import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/IntroControllers/auth_controller.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/screens/IntroScreens/LoginScreen/login_screen.dart';
import 'package:sanaiey/screens/SharedComponents/loader.dart';
import 'package:sanaiey/utils/responsive.dart';

class VerificationLogin extends StatefulWidget {
  const VerificationLogin({Key? key}) : super(key: key);

  @override
  _VerificationLoginState createState() => _VerificationLoginState();
}

class _VerificationLoginState extends State<VerificationLogin> {
  String code = '';

  String? errorMessage;
  bool hasError = false;
  int pinLength = 4;
  double theHeightOFSizedBoxOverWhiteCard = 0.5;
  String thisText = "";
  int _start = 10;
  Timer? _timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        body: SizedBox(
          height: height(context),
          width: width(context),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  const CustomBackgroundImage(
                    imagePath: "assets/icons/lock.png",
                    widthPercentage: .2,
                  ),
                ],
              ),
              SizedBox(
                height: height(context),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomSizedBox(percentageOfHeight: .35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: width(context) * .9,
                            decoration: decorationRadius(),
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CustomSizedBox(percentageOfHeight: .03),
                                Text(
                                  'برجاء إدخال الكود',
                                  style: titleBold(color: mainColor, size: 20),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Text(
                                    'برجاء إدخال الكود المكون من 4'
                                    ' ارقام المرسل إلى رقم ${Get.find<AuthController>().phoneController.text}',
                                    style: titleNormal(color: mainColor),
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const CustomSizedBox(percentageOfHeight: .01),
                                PinCodeTextField(
                                  defaultBorderColor: whiteColor,
                                  pinBoxColor: backGroundColor,
                                  errorBorderColor: Colors.red,
                                  hasTextBorderColor: greyColor.withOpacity(.2),
                                  autofocus: false,
                                  controller: Get.find<AuthController>().otpController,
                                  maxLength: pinLength,
                                  hasError: hasError,
                                  onTextChanged: (text) {
                                    setState(() {
                                      hasError = false;
                                    });
                                  },
                                  pinBoxWidth: 50,
                                  pinBoxHeight: 64,
                                  hasUnderline: false,
                                  wrapAlignment: WrapAlignment.spaceAround,
                                  pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                                  pinTextStyle: const TextStyle(fontSize: 22.0),
                                  pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                                  pinTextAnimatedSwitcherDuration: const Duration(
                                    milliseconds: 300,
                                  ),
                                  highlightAnimationBeginColor: Colors.black,
                                  highlightAnimationEndColor: Colors.white12,
                                  keyboardType: TextInputType.number,
                                ),
                                Visibility(
                                  child: const Text(
                                    "Wrong PIN!",
                                  ),
                                  visible: hasError,
                                ),
                                const CustomSizedBox(percentageOfHeight: .04),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GetBuilder<AuthController>(
                                      builder: (controller) => controller.loadingVerification
                                          ? SizedBox(
                                              width: 170.w,
                                              height: 50.h,
                                              child: Center(child: loader),
                                            )
                                          : InkWell(
                                              onTap: () => controller.verifyLogin(
                                                // otp: otpController.text,
                                                context: context,
                                              ),
                                              child: Container(
                                                width: 170.w,
                                                height: 50.h,
                                                // margin: EdgeInsets.all(16.w),
                                                decoration: decorationRadius().copyWith(
                                                  color: const Color(0xFFAE0910),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'تحقق الان',
                                                    style: titleNormal(
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                    SizedBox(width: width(context) * .05),
                                    InkWell(
                                      onTap: () => Navigator.pop(context),
                                      child: Container(
                                        width: 90.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          border: Border.all(color: mainColor),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: const Center(
                                          child: CustomText(
                                            textColor: mainColor,
                                            text: "رجوع",
                                            percentageOfHeight: .018,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // const CustomSizedBox(percentageOfHeight: .02),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     const CustomText(
                                //       text: "تنتهي بعد ...",
                                //       percentageOfHeight: 0.018,
                                //       textColor: greyColor,
                                //       fontWeight: FontWeight.bold,
                                //       maxLines: 3,
                                //     ),
                                //     CustomText(
                                //         text: _start.toString(),
                                //         percentageOfHeight: 0.018,
                                //         textColor: mainColor,
                                //         fontWeight: FontWeight.bold,
                                //         maxLines: 3),
                                //   ],
                                // ),
                                // const CustomSizedBox(percentageOfHeight: .01),

                                ///
                                /// Resend the OTP
                                ///
                                SizedBox(height: 8.h),
                                GetBuilder<AuthController>(
                                  builder: (controller) => controller.loadingResend
                                      ? SizedBox(
                                          width: 120.w,
                                          height: 30.h,
                                          child: Center(child: loader),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            print('esss');
                                            controller.resendCode(
                                              context: context,
                                            );
                                          },
                                          child: SizedBox(
                                            width: 200.w,
                                            height: 60.h,
                                            child: Center(
                                              child: Text(
                                                'إرسال الكود مرة أخرى',
                                                style: titleNormal(color: mainColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                                SizedBox(height: 8.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
