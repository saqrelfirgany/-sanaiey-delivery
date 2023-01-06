import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/navigation_controller.dart';
import 'package:sanaiey/screens/MainScreens/NavigationHome/body/nav_icon.dart';

import 'TabClipper.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GetBuilder<NavigationController>(
        builder: (navController) => ClipPath(
          clipper: TabClipper(),
          child: Container(
            width: double.infinity,
            height: 60.h,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(26.r),
                topEnd: Radius.circular(26.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: NavIcon(
                      index: 4,
                      currentIndex: navController.index,
                      image: 'assets/icons/more.png',
                      activeImage: 'assets/icons/more.png',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => navController.changeIndexFunction(1, context),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(end: 34.w),
                    child: NavIcon(
                      index: 1,
                      currentIndex: navController.index,
                      image: 'assets/icons/order.png',
                      activeImage: 'assets/icons/order.png',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => navController.changeIndexFunction(3, context),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: 34.w),
                    child: NavIcon(
                      index: 3,
                      currentIndex: navController.index,
                      image: 'assets/icons/subscription.png',
                      activeImage: 'assets/icons/subscription.png',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => navController.changeIndexFunction(0, context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: NavIcon(
                      index: 0,
                      currentIndex: navController.index,
                      image: 'assets/icons/home.png',
                      activeImage: 'assets/icons/home.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
