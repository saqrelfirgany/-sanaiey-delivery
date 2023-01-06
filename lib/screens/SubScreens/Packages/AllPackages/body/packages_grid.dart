import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/main_loader.dart';
import 'package:sanaiey/screens/SubScreens/Packages/PackageDetails/package_details.dart';

class PackagesGrid extends StatefulWidget {
  const PackagesGrid({
    Key? key,
    required this.text,
    required this.subText,
    required this.description,
  }) : super(key: key);
  final String text;
  final String subText;
  final String description;

  @override
  State<PackagesGrid> createState() => _PackagesGridState();
}

class _PackagesGridState extends State<PackagesGrid> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepartmentController>(
      builder: (controller) => controller.sub0Stage == DepartmentStage.LOADING
          ? SizedBox(
              width: double.infinity,
              height: 400.h,
              child: MainLoader(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                // itemCount: homeProvider.categoriesImages.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: List.generate(
                  // controller.expertsList.length,
                  8,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 8.w,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.r),
                      elevation: 6,
                      child: Material(
                        borderRadius: BorderRadius.circular(10.r),
                        elevation: 6,
                        child: InkWell(
                          onTap: () {
                            fadNavigate(context, PackageDetails());
                            // controller.setServiceId(
                            //   id: '${controller.departmentSub0List[index].departmentId}',
                            // );
                            // controller.changeServiceIndexWithoutUpdate(i: index);
                            // fadNavigate(
                            //   context,
                            //   ServicesScreen(
                            //     text: widget.text,
                            //     subText: widget.subText,
                            //     description: widget.description,
                            //   ),
                            // );
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.w),
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
                              border: Border.all(width: 1, color: Colors.grey.shade400),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  offset: const Offset(0, 0),
                                  blurRadius: 4.0,
                                )
                              ],
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/icons/normal_cleaning.png',
                                width: double.infinity,
                                height: double.infinity,
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
            ),
    );
  }
}
