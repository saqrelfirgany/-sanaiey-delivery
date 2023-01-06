import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/screens/IntroScreens/RegisterScreen/register_screen.dart';
import 'package:sanaiey/utils/responsive.dart';

import 'animated_dialog.dart';


void AccountDialog({required BuildContext? context, required String phone}) {
  showAnimatedDialog(
    context!,
    RotatedRDialog(
      child: Container(
        width: 340.w,
        // height: 280.h,
        padding: EdgeInsets.all(16.w),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            Text(
              'ليس لديك حساب لدينا على هذا الرقم',
              style: titleNormal(color: mainColor),
            ),
            Text(
              phone,
              style: titleNormal(color: mainColor),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => fadNavigate(context, RegisterScreen()),
                  child: Container(
                    width: 130.w,
                    height: 46.h,
                    decoration: decorationRadius().copyWith(
                      color: const Color(0xFFAE0910),
                    ),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          'انشاء حساب جديد',
                          style: titleNormal(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width(context) * .05),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 130.w,
                    height: 46.h,
                    decoration: decorationRadiusBorder(color: mainColor),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          'إلغاء',
                          style: titleNormal(color: mainColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const CustomSizedBox(percentageOfHeight: .03),
          ],
        ),
      ),
    ),
    isFlip: true,
  );
}
