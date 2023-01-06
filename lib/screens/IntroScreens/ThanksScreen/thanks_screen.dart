import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/screens/IntroScreens/LoginScreen/login_screen.dart';
import 'package:sanaiey/screens/IntroScreens/SelectAddress/select_address.dart';
import 'package:sanaiey/screens/SharedComponents/Buttons/auth_button.dart';


class ThanksScreen extends StatelessWidget {
  const ThanksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 120.h),
            const CustomBackgroundImage(
              imagePath: "assets/images/thank.png",
            ),
            SizedBox(height: 8.h),
            Text(
              'شكراً',
              style: titleNormal(color: Colors.white, size: 18),
            ),
            // SizedBox(height: 8.h),
            Text(
              'تم التفعيل بنجاح',
              style: titleNormal(color: Colors.white, size: 18),
            ),
            SizedBox(height: 8.h),
            AuthButton(
              text: 'حسناً',
              press: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => const SelectAddressScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
