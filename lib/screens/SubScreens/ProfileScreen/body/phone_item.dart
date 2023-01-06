import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Models/SubModel/phone_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/screens/SharedComponents/loader.dart';
import 'package:sanaiey/screens/SubScreens/ProfileScreen/body/profile_dialog.dart';

class PhoneItem extends StatelessWidget {
  const PhoneItem({Key? key, required this.phone}) : super(key: key);
  final PhoneModel phone;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: decorationDoubleRadiusBorder(),
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsetsDirectional.only(bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(CupertinoIcons.phone),
                  SizedBox(width: 8.w),
                  SizedBox(
                    width: 240.w,
                    child: Text(
                      '${phone.clientPhone}',
                      style: titleNormal(color: Colors.black),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              GetBuilder<UserController>(
                builder: (userController) => userController.loading
                    ? loader
                    : GestureDetector(
                        onTap: () => Get.find<UserController>().deletePhone(id: '${phone.clientPhoneId}'),
                        child: const Icon(CupertinoIcons.delete),
                      ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Get.find<UserController>().setPhone(phone: phone);
                  ProfileDialog(
                      context: context,
                      controller: Get.find<UserController>().phoneController,
                      press: () => Get.find<UserController>().updatePhone(),
                      title: 'تعديل');
                },
                child: Text(
                  'تعديل',
                  style: titleNormal(color: mainColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
