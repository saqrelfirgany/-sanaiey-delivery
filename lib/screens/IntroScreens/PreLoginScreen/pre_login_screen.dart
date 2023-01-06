import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/IntroControllers/auth_controller.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/screens/IntroScreens/LoginScreen/login_screen.dart';
import 'package:sanaiey/screens/IntroScreens/RegisterScreen/register_screen.dart';
import 'package:sanaiey/screens/SharedComponents/Buttons/auth_button.dart';
import 'package:sanaiey/screens/SharedComponents/TextFormFields/text_field_phone.dart';
import 'package:sanaiey/utils/responsive.dart';

class PreLoginScreen extends StatefulWidget {
  const PreLoginScreen({Key? key}) : super(key: key);

  @override
  _PreLoginScreenState createState() => _PreLoginScreenState();
}

class _PreLoginScreenState extends State<PreLoginScreen> {
  @override
  Widget build(BuildContext context) {
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
                          width: width(context) * .95,
                          decoration: decorationDoubleRadiusBorder(color: Colors.white),
                          child: Column(
                            children: [
                              Text(
                                'تسجيل الدخول',
                                style: titleBold(color: mainColor, size: 20),
                              ),
                              Text(
                                'برجاء ادخال رقم الهاتف من اجل المتابعه',
                                style: titleNormal(color: mainColor),
                              ),
                              SizedBox(height: 16.h),
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
                                    // const SizedBox(),
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
                              SizedBox(height: 24.h),
                              AuthButton(
                                press: Get.find<AuthController>().preLogin,
                                text: 'دخول',
                                padding: 0,
                              ),
                              SizedBox(height: 16.h),
                              GetBuilder<AuthController>(
                                builder: (controller) => controller.loading
                                    ? Container()
                                    : TextButton(
                                        onPressed: () {
                                          fadNavigate(context, const RegisterScreen());
                                        },
                                        child: Text(
                                          'ليس لديك حساب ! انشاء حساب جديد ',
                                          style: titleNormal(color: mainColor, size: 15),
                                        ),
                                      ),
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
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
