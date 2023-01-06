import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';

import 'animated_dialog.dart';

void AppDialog2({required BuildContext? context,required String text}) {
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
            Text(
              text,
              maxLines: 10,
              textAlign: TextAlign.center,
              style: titleNormal(color: Colors.black),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 160.w,
                    height: 46.h,
                    decoration: decorationRadius().copyWith(
                      color: const Color(0xFFAE0910),
                    ),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          'حسنا',
                          style: titleNormal(color: Colors.white),
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