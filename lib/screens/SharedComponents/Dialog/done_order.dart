import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/navigation_controller.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/screens/IntroScreens/RegisterScreen/register_screen.dart';
import 'package:sanaiey/screens/MainScreens/HomeScreen/home_screen.dart';
import 'package:sanaiey/screens/MainScreens/OrderScreens/orders/my_orders_screen.dart';
import 'package:sanaiey/utils/responsive.dart';

import '../../../controllers/MainControllers/order_controller.dart';
import '../../SubScreens/OrdersDetails/orders_details.dart';
import 'animated_dialog.dart';

void DoneOrderDialog({required BuildContext? context,required String Id}) {
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
            Image.asset(
              'assets/images/order_done.png',
              width: 120.w,
              height: 120.h,
            ),
            Text(
              'شكرا',
              style: titleNormal(color: Colors.black, size: 18),
            ),
            Text(
              'تم ارسال طلبك لمقدم الخدمة ,يمكنك',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: titleNormal(color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ' مراجعة طلبك',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: titleNormal(color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    Get.find<OrderController>().setOrderDetailsId(id: '$Id');
                    Get.find<NavigationController>().changeIndexFunction(1, context);
                    fadNavigate(context, const OrdersDetailsScreen());
                  },
                  child: Text(
                    ' من هنا',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: titleNormal(color: Colors.red.shade900),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.find<NavigationController>().changeIndexFunction(0, context);
                    // fadNavigate(context, MyOrdersScreen());
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => const HomeScreen(),
                    //   ),
                    //   (route) => false,
                    // );
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
