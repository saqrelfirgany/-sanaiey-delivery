import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/main_loader.dart';
import 'package:sanaiey/screens/SubScreens/ServicesScreen/service_screen.dart';

import '../../ServicesScreen/service_screen.dart';

class DepDetailsUpdateGrid extends StatefulWidget {
  const DepDetailsUpdateGrid({
    Key? key,
    required this.text,
    required this.subText,
    required this.description,
    this.showBottomNav =true,
  }) : super(key: key);
  final String text;
  final String subText;
  final String description;
  final bool showBottomNav;

  @override
  State<DepDetailsUpdateGrid> createState() => _DepDetailsUpdateGridState();
}

class _DepDetailsUpdateGridState extends State<DepDetailsUpdateGrid> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepartmentController>(
      builder: (controller) => controller.sub0Stage == DepartmentStage.LOADING
          ? SizedBox(
              width: double.infinity,
              height: 282.h,
              child: MainLoader(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                // itemCount: homeProvider.categoriesImages.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: List.generate(
                  // controller.expertsList.length,
                  controller.departmentSub0List.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 8.w,
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.setServiceId(
                          id: '${controller.departmentSub0List[index].departmentId}',
                        );
                        controller.changeServiceIndexWithoutUpdate(i: index);
                        // controller.changeIndex(i: index);
                        fadNavigate(
                          context,
                          ServicesUpdateScreen(
                            text: widget.text,
                            subText: widget.subText,
                            description: widget.description,
                            showBottomNav: widget.showBottomNav,
                          ),
                        );
                      },
                      child: PhysicalModel(
                        color: Colors.white,
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFFFFFF),
                                Color(0xFFF2F2F2),
                              ],
                              begin: AlignmentDirectional.topCenter,
                              end: AlignmentDirectional.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(width: 1, color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                offset: const Offset(0, 0),
                                blurRadius: 4.0,
                              )
                            ],
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                '${controller.departmentSub0List[index].departmentSub1}',
                                style: titleNormal(color: Colors.black),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
