import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/navigation_controller.dart';

class CartNavIcon extends StatelessWidget {
  const CartNavIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (navController) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => navController.changeIndexFunction(2, context),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                color: mainColor,
                shape: BoxShape.circle,
              ),
              height: 60.h,
              width: 60.w,
              padding: EdgeInsets.all(16.w),
              child: Center(
                child: Image.asset('assets/icons/cart.png'),
              ),
            ),
          ),
          // SizedBox(height: 20.h),
          // Container(
          //   width: width(context) * .12,
          //   height: 8,
          //   color: navController.index == 2 ? secondaryColor : mainColor,
          // ),
          // SizedBox(height: 16.h),
          SizedBox(height: 16.h),
          navController.index == 2
              ? Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.shade900,
                  ),
                )
              :  SizedBox(height: 10.w),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
