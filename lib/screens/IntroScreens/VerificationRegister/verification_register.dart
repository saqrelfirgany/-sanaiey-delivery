import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/IntroControllers/auth_controller.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/screens/IntroScreens/LoginScreen/login_screen.dart';
import 'package:sanaiey/screens/SharedComponents/Buttons/auth_button.dart';
import 'package:sanaiey/screens/SharedComponents/Buttons/back_button.dart';
import 'package:sanaiey/screens/SharedComponents/loader.dart';
import 'package:sanaiey/utils/responsive.dart';

class VerificationRegister extends StatefulWidget {
  const VerificationRegister({Key? key, required this.phone}) : super(key: key);

  final String phone;

  @override
  _VerificationRegisterState createState() => _VerificationRegisterState();
}

class _VerificationRegisterState extends State<VerificationRegister> {
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

  late AuthController authController;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    authController = Get.find<AuthController>();
    authController.otpController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 70.h),
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
                              Text(
                                'برجاء إدخال الكود',
                                style: titleBold(color: mainColor, size: 20),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Text(
                                  'برجاء إدخال الكود المكون من 4'
                                  ' ارقام المرسل إلى رقم ${widget.phone}',
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
                                controller: authController.otpController,
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
                                pinTextAnimatedSwitcherTransition:
                                    ProvidedPinBoxTextAnimation.scalingTransition,
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
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: 8.w,
                                  bottom: 16.h,
                                  end: 34.w,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AuthButton(
                                      press: Get.find<AuthController>().verificationRegister,
                                      width: 160.w,
                                      height: 48.h,
                                      text: 'انشاء حساب',
                                    ),
                                    AuthBack(
                                      text: 'رجوع',
                                      width: 100.w,
                                      height: 48.h,
                                    )
                                  ],
                                ),
                              ),

                              ///
                              /// Resend the OTP
                              ///
                              GetBuilder<AuthController>(
                                builder: (controller) => controller.loadingResend
                                    ? SizedBox(
                                        width: 120.w,
                                        height: 30.h,
                                        child: Center(child: loader),
                                      )
                                    : TextButton(
                                        onPressed: () {
                                          controller.resendCode(context: context);
                                        },
                                        child: Text(
                                          'إرسال الكود مرة أخرى',
                                          style: titleNormal(color: mainColor),
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
    );
  }
}
