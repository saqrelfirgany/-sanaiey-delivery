import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/cart_controller.dart';
import 'package:sanaiey/controllers/MainControllers/navigation_controller.dart';

class QuantityAndServicesNavBar extends StatelessWidget {
  const QuantityAndServicesNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (navController) => GetBuilder<CartController>(
        builder: (cartController) => GestureDetector(
          onTap: () => navController.changeIndexFunction(2, context),
          child: Container(
            width: double.infinity,
            height: 60.h,
            color: mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 32.w),
                Container(
                  width: 40.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: whiteColor, width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${cartController.cartServiceQuantity}',
                      style: titleNormal(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 32.w),
                Text(
                  'انظر سلة المنتجات',
                  style: titleNormal(color: Colors.white),
                ),
                SizedBox(width: 32.w),
                Text(
                  'الإجمالى ${cartController.cartModel.totalPrice ?? '0'} ج',
                  style: titleNormal(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
