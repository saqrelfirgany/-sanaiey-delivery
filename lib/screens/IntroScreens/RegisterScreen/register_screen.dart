import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/IntroControllers/auth_controller.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/screens/IntroScreens/LoginScreen/login_screen.dart';
import 'package:sanaiey/screens/SharedComponents/Buttons/auth_button.dart';
import 'package:sanaiey/screens/SharedComponents/Buttons/back_button.dart';
import 'package:sanaiey/screens/SharedComponents/TextFormFields/text_field_register.dart';
import 'package:sanaiey/utils/responsive.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    authController = Get.find<AuthController>();
    authController.nameController.text = '';
    authController.phoneController.text = '';
    authController.emailController.text = '';
    authController.passwordController.text = '';
  }

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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 44.h),
                  Text(
                    'يلا نبدأ !',
                    style: titleBold(color: Colors.white, size: 18),
                  ),
                  Text(
                    'قم بالتسجيل لدينا للإستمرار',
                    style: titleNormal(color: Colors.white, size: 18),
                  ),
                  SizedBox(height: 16.h),
                  const CustomBackgroundImage(
                    imagePath: "assets/icons/logo.png",
                    widthPercentage: .2,
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomSizedBox(percentageOfHeight: .42),
                    Center(
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(height: 8.h),
                            Text(
                              'انشاء حساب جديد',
                              style: titleBold(color: mainColor, size: 20),
                            ),
                            SizedBox(height: 8.h),

                            ///
                            /// Name
                            ///
                            TextFieldRegister(
                              controller: authController.nameController,
                              textInputType: TextInputType.text,
                              hint: 'الاسم ثنائي',
                              prefixIconPath: Icons.person_outline,
                            ),
                            SizedBox(height: 2.h),

                            ///
                            /// Phone
                            ///
                            TextFieldRegister(
                              controller: authController.phoneController,
                              textInputType: TextInputType.number,
                              hint: 'رقم الهاتف',
                              prefixIconPath: Icons.phone_android,
                            ),
                            SizedBox(height: 2.h),

                            ///
                            /// Email
                            ///
                            TextFieldRegister(
                              controller: authController.emailController,
                              textInputType: TextInputType.emailAddress,
                              hint: 'البريد الإلكتروني',
                              prefixIconPath: Icons.email_outlined,
                            ),
                            SizedBox(height: 2.h),

                            ///
                            /// Password
                            ///
                            TextFieldRegister(
                              controller: authController.passwordController,
                              textInputType: TextInputType.text,
                              hint: 'كلمة المرور',
                              prefixIconPath: Icons.lock_outline,
                            ),
                            SizedBox(height: 24.h),

                            ///
                            /// Buttons
                            ///
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
                                    press: Get.find<AuthController>().register,
                                    width: 170.w,
                                    height: 48.h,
                                    text: 'انشاء حساب',
                                  ),
                                  AuthBack(
                                    text: 'رجوع',
                                    width: 135.w,
                                    height: 48.h,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                        width: width(context) * .95,
                        decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const CustomSizedBox(percentageOfHeight: .04)
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
