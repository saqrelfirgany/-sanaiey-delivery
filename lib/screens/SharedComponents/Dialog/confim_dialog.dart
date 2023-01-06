import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';

import 'animated_dialog.dart';

void ConfirmDialog({required String text,required VoidCallback onConfirm}) {
  showAnimatedDialog(
    Get.context!,
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
              text,
              maxLines: 10,
              textAlign: TextAlign.center,
              style: titleNormal(color: mainColor, size: 18),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      width: 160.w,
                      height: 40.h,
                      decoration: decorationRadius().copyWith(
                        color: const Color(0xFFAE0910),
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            'تأكيد',
                            style: titleNormal(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(Get.context!),
                    child: Container(
                      width: 160.w,
                      height: 40.h,
                      decoration: decorationRadiusBorder(color: mainColor),
                      child: Center(
                        child: Text(
                          'إلغاء',
                          style: titleNormal(
                            color: mainColor,
                            size: 18,
                          ),
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
