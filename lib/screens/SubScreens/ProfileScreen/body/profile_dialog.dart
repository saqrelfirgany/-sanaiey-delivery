import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/animated_dialog.dart';
import 'package:sanaiey/screens/SharedComponents/TextFormFields/text_field_update.dart';
import 'package:sanaiey/screens/SharedComponents/loader.dart';
import 'package:sanaiey/utils/responsive.dart';

void ProfileDialog({
  required BuildContext context,
  required TextEditingController controller,
  required VoidCallback press,
  TextInputType textInputType = TextInputType.text,
  String title = 'تحديث',
}) {
  showAnimatedDialog(
    context,
    RotatedRDialog(
      child: Container(
        width: 340.w,
        // height: 280.h,
        padding: EdgeInsets.all(16.w),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            TextFieldUpdate(
              controller: controller,
              textInputType: textInputType,
            ),
            SizedBox(height: 16.h),
            GetBuilder<UserController>(
              builder: (userController) => userController.loading
                  ? loader
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: press,
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
                                  title,
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
            ),
            const CustomSizedBox(percentageOfHeight: .03),
          ],
        ),
      ),
    ),
    isFlip: true,
  );
}
