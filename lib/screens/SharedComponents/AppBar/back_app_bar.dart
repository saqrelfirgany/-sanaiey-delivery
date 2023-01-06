import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';

import 'home_app_bar.dart';

class BackAppBar extends StatelessWidget {
  const BackAppBar({Key? key, this.title = ''}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 414.w,
      margin: EdgeInsets.only(bottom: 2.h),
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            // overflow: Overflow.visible,
            children: [
              PositionedDirectional(
                bottom: -22.h,
                start: 40.w,
                child: Container(
                  width: 160.w,
                  height: 20.h,
                  padding: EdgeInsetsDirectional.only(end: 36.w),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(20.r),
                      bottomStart: Radius.circular(20.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GetBuilder<UserController>(
                        builder: (userController) => Container(
                          width: 94.w,
                          // color: Colors.blue,
                          padding: EdgeInsetsDirectional.only(top: 1.h),
                          alignment: AlignmentDirectional.topEnd,
                          child: Text(
                            '${Get.find<UserController>().addressModel.addressRegion ?? 'العنوان'} ',
                            textAlign: TextAlign.end,
                            style: titleNormal(color: Colors.white, size: 8),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Image.asset(
                        'assets/icons/location.png',
                        width: 10.w,
                        height: 10.w,
                      ),
                      // SizedBox(width: 34.w),
                    ],
                  ),
                ),
              ),

              Container(
                width: double.infinity,
                height: 98.h,
                padding: EdgeInsets.symmetric(vertical: 36.h),
                color: mainColor,
                // margin: EdgeInsets.only(bottom: 16.h),
              ),
              PositionedDirectional(
                end: 0.w,
                bottom: 10.h,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(CupertinoIcons.forward, color: Colors.white, size: 30.w),
                ),
              ),
              PositionedDirectional(
                start: 0.w,
                bottom: 10.h,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.bell, color: Colors.white, size: 30.w),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 35.h),
                  child: Text(
                    title,
                    style: titleBold(color: Colors.white),
                  ),
                ),
              ),
              // AnimationAppBar(),
              PositionedDirectional(
                bottom: -30.h,
                start: 165.w,
                child: AnimationAppBar(
                  logo: Container(
                    width: 80.w,
                    // width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      border: Border.all(width: 5, color: mainColor),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/app_logo_2.png',
                      width: 74.w,
                      height: 74.w,
                    ),
                  ),
                ),
              ),

            ],
          ),
          AppBarBottomSheet(),
        ],
      ),
    );
  }
}

class AnimationAppBar extends StatefulWidget {
  const AnimationAppBar({Key? key, required this.logo}) : super(key: key);
  final Widget logo;

  @override
  _AnimationAppBarState createState() => _AnimationAppBarState();
}

class _AnimationAppBarState extends State<AnimationAppBar> with TickerProviderStateMixin {
  late final AnimationController _container = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  )..repeat();

  @override
  void dispose() {
    _container.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _container,
        child: widget.logo,
        builder: (context, child) {
          return Transform.rotate(
            angle: _container.value * 2 * math.pi,
            child: child,
          );
        },
      ),
    );
  }
}
