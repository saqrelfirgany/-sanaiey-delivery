import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/Models/SubModel/address_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/screens/SharedComponents/loader.dart';
import 'package:sanaiey/screens/SubScreens/ProfileScreen/profile_screen.dart';
import 'package:sanaiey/utils/responsive.dart';

import 'animated_dialog.dart';

void AddressDialog({required BuildContext? context}) {
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
            Container(
              height: 50.h,
              alignment: AlignmentDirectional.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'تحديث العنوان الافتراضي',
                    style: titleNormal(color: mainColor),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      fadNavigate(context, ProfileScreen());
                    },
                    child: Text(
                      'عناويني',
                      style: titleNormal(color: mainColor),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: mainColor, size: 18.w),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            GetBuilder<UserController>(
              init: Get.find<UserController>(),
              builder: (userController) => Container(
                width: double.infinity,
                height: 45.h,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: backGroundColor,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: const Color(0xFFBEBEBE),
                  ),
                ),
                child: DropdownButtonFormField<AddressModel>(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsetsDirectional.only(
                      start: 16.w,
                      end: 8.w,
                      bottom: 4.h,
                    ),
                  ),
                  isDense: false,
                  itemHeight: 55.h,
                  // menuMaxHeight: 220,
                  isExpanded: false,
                  hint: Container(
                    // color: Colors.blue,
                    width: 200.w,
                    child: Text(
                      'برجاء تحديد العنوان الافتراضي',
                      style: cairoW400(color: Colors.black, size: 14),
                    ),
                  ),
                  dropdownColor: backGroundColor,
                  iconEnabledColor: Colors.black,
                  iconDisabledColor: Colors.black,
                  // value: userController.addressList[0],
                  items: userController.addressList
                      .map(
                        (item) => DropdownMenuItem<AddressModel>(
                          value: item,
                          child: Container(
                            // color: Colors.blue,
                            width: 200.w,
                            child: Text(
                              item.addressRegion ?? 'العنوان الافتراضي',
                              maxLines: 1,
                              style: titleNormal(color: const Color(0xFF949494),size: 14),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (item) {
                    userController.changeAddress(changeAddress: item);
                  },
                ),
              ),
            ),
            SizedBox(height: 16.h),
            GetBuilder<UserController>(
              builder: (userController) => userController.loading
                  ? SizedBox(
                      height: 46.h,
                      child: loader,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            userController.updateDefaultAddress();
                          },
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
                                  'تحديث',
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
