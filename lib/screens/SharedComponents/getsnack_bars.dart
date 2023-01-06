import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';

void showError({String title='', required String body}) {
  Fluttertoast.showToast(
    msg: body,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.sp,
  );
}
void showToast({required String body}) {
  Fluttertoast.showToast(
    msg: body,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.white,
    textColor: mainColor,
    fontSize: 16.sp,
  );
}
void getSnackBar({required String message}) {
  var snackBar = SnackBar(
    content: Text(
      message.tr,
      style: cairoW400(color: Colors.white),
    ),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
}
