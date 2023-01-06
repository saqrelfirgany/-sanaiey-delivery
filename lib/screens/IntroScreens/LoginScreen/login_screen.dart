import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/IntroControllers/auth_controller.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/screens/SharedComponents/Buttons/auth_button.dart';
import 'package:sanaiey/screens/SharedComponents/Buttons/back_button.dart';
import 'package:sanaiey/screens/SharedComponents/TextFormFields/text_field_phone.dart';
import 'package:sanaiey/screens/SharedComponents/loader.dart';
import 'package:sanaiey/utils/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double theHeightOFSizedBoxOverWhiteCard = 0.5;

  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().passwordController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    var index = 0;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: mainColor,
        body: SizedBox(
          height: height(context),
          width: width(context),
          child: Stack(
            children: [
              setLocationImage(
                context: context,
                imagePath: "assets/images/delivery_man1.png",
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomSizedBox(percentageOfHeight: .42),
                    Center(
                      child: PhysicalModel(
                        color: Colors.white,
                        elevation: 8,
                        shadowColor: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                'تسجيل الدخول',
                                style: titleBold(color: mainColor, size: 20),
                              ),
                              SizedBox(
                                width: width(context) * .8,
                                child: Text(
                                  'رقم الهاتف',
                                  style: titleNormal(color: mainColor),
                                ),
                              ),
                              SizedBox(
                                width: width(context) * .8,
                                height: 48.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ///
                                    /// Phone FormField
                                    ///
                                    TextFieldPhone(
                                        controller: Get.find<AuthController>().phoneController),
                                    Container(
                                      width: 48.w,
                                      height: 48.h,
                                      decoration: decorationRadiusBorder(color: mainColor),
                                      child: Center(
                                        child: Text(
                                          ' 20 +',
                                          style: titleBold(color: mainColor),
                                        ),
                                      ),
                                    ),
                                    const Icon(Icons.check, color: mainColor),
                                  ],
                                ),
                              ),
                              // const CustomSizedBox(percentageOfHeight: .03),
                              SizedBox(
                                width: width(context) * .8,
                                child: Text(
                                  'كلمة المرور',
                                  style: titleNormal(color: mainColor),
                                ),
                              ),
                              SizedBox(
                                width: width(context) * .8,
                                height: 48.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // const SizedBox(),

                                    ///
                                    /// Password FormField
                                    ///
                                    TextFieldPhone(
                                      controller: Get.find<AuthController>().passwordController,
                                      textInputType: TextInputType.text,
                                      obscureText: true,
                                    ),
                                    Container(
                                      width: 48.w,
                                      height: 48.h,
                                      decoration: decorationRadiusBorder(color: mainColor),
                                      child: const Center(
                                        child: Icon(Icons.lock_outline, color: mainColor),
                                      ),
                                    ),
                                    const Icon(Icons.check, color: mainColor),
                                  ],
                                ),
                              ),
                              GetBuilder<AuthController>(
                                builder: (controller) => controller.loading
                                    ? Container(
                                        height: 50.h,
                                      )
                                    : controller.loadingVerification
                                        ? SizedBox(
                                            width: 40.w,
                                            height: 60.h,
                                            child: Center(child: loader),
                                          )
                                        : TextButton(
                                            onPressed: () {
                                              Get.find<AuthController>().loginWithOTP(context: context);
                                            },
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.only(
                                                start: 28.w,
                                                top: 8.h,
                                                bottom: 16.h,
                                                end: 8.w,
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'الدخول عن طريق كود على رقمك',
                                                    style: titleNormal(color: mainColor, size: 15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                // InkWell(
                                //             onTap: () =>
                                //                 Get.find<AuthController>().loginWithOTP(context: context),
                                //             child: Padding(
                                //               padding: EdgeInsetsDirectional.only(
                                //                 start: 28.w,
                                //                 top: 8.h,
                                //                 bottom: 16.h,
                                //                 end: 8.w,
                                //               ),
                                //               child: Row(
                                //                 children: [
                                //                   Text(
                                //                     'لا اتذكر كلمة المرور !',
                                //                     style: titleNormal(color: mainColor, size: 15),
                                //                   ),
                                //                 ],
                                //               ),
                                //             ),
                                //           ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: 34.w,
                                  bottom: 16.h,
                                  end: 34.w,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AuthButton(
                                      press: Get.find<AuthController>().login,
                                      width: 170.w,
                                      height: 48.h,
                                      text: 'تسجيل الدخول',
                                    ),
                                    AuthBack(
                                      text: 'رجوع',
                                      width: 135.w,
                                      height: 48.h,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          width: width(context) * .95,
                          decoration:
                              BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ),
                    const CustomSizedBox(percentageOfHeight: .04),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBackgroundImage extends StatelessWidget {
  final String imagePath;
  final double widthPercentage;

  const CustomBackgroundImage({this.imagePath = "", this.widthPercentage = 0.4});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          isLandscape(context) ? 2 * height(context) * widthPercentage : height(context) * widthPercentage,
      width: width(context),
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(imagePath))),
    );
  }
}

setLocationImage({BuildContext? context, String imagePath: "assets/images/set_location.png"}) {
  return Container(
    height: isLandscape(context!) ? 2 * height(context) * .4 : height(context) * .4,
    width: width(context),
    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(imagePath))),
  );
}
