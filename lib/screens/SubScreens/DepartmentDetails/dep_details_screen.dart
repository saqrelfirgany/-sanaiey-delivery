import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';
import 'package:sanaiey/screens/MainScreens/DepartmentScreen/body/department_hearder.dart';
import 'package:sanaiey/screens/MainScreens/HomeScreen/home_screen.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';

import 'body/dep_details_grid.dart';
import 'body/dep_details_row.dart';

class DepDetailsScreen extends StatefulWidget {
  const DepDetailsScreen({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String title;
  final String description;

  @override
  State<DepDetailsScreen> createState() => _DepDetailsScreenState();
}

class _DepDetailsScreenState extends State<DepDetailsScreen> {
  ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
    getData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> getData() async {
    await Get.find<DepartmentController>().getDepartmentRowItems();
    Get.find<DepartmentController>().changeDepRowIndexWithoutUpdate(i: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            BackAppBar(title: 'الاقسام'),
            // SizedBox(height: 40),
            Container(
              width: 414.w,
              height: 580.h,
              child: GetBuilder<DepartmentController>(
                builder: (controller) => controller.depLev1Stage == DepartmentStage.LOADING
                    ? const ScreenLoader()
                    : Reload(
                        load: () async {
                          await getData();
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///
                            /// Slider
                            ///
                            SizedBox(height: 8.h),
                            DepartmentSlider(),
                            SizedBox(height: 8.h),

                            ///
                            /// Department Header
                            ///
                            DepartmentHeader(text: '${widget.title}'),
                            SizedBox(height: 8.h),

                            ///
                            /// Sub Title
                            ///
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                // vertical: 8.w,
                              ),
                              child: SizedBox(
                                width: 736.w,
                                child: Text(
                                  widget.description,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: titleNormal(color: Colors.black, size: 14),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 4.w,
                              ),
                              child: SizedBox(
                                width: 736.w,
                                child: Text(
                                  'أختر نوع الخدمة',
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: titleNormal(color: Colors.black, size: 16),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
                              child: SizedBox(
                                width: 160.w,
                                child: const Divider(color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 8.h),

                            ///
                            /// Row
                            ///
                            const DepDetailsRow(),
                            SizedBox(height: 16.h),
                            Expanded(
                              child: DepDetailsGrid(
                                text: widget.title,
                                subText: controller.departmentSub0,
                                description: widget.description,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceGuarantee extends StatelessWidget {
  const ServiceGuarantee({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 341.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      color: Color(0xFF00000029),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 736.w,
            child: Text(
              'نحن نضمن',
              maxLines: 2,
              textAlign: TextAlign.start,
              style: titleNormal(color: Colors.black),
            ),
          ),
          SizedBox(
            width: 86.w,
            height: 8.h,
            child: Divider(color: Colors.grey.shade800),
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.timer, size: 40.w),
              SizedBox(width: 8.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ضمان علي الخدمة',
                    style: titleBold(color: Colors.black, size: 14),
                  ),
                  Text(
                    'حتي 30 يوم من تاريخ إنتهاء الخدمة',
                    style: titleNormal(color: Colors.black, size: 14),
                  ),
                ],
              ),
            ],
          ),
          // SizedBox(height: 4.h),
          const Divider(color: mainColor),
          // SizedBox(height: 4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.timer, size: 40.w),
              SizedBox(width: 8.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ضمان علي الخدمة',
                    style: titleBold(color: Colors.black, size: 14),
                  ),
                  Text(
                    'حتي 30 يوم من تاريخ إنتهاء الخدمة',
                    style: titleNormal(color: Colors.black, size: 14),
                  ),
                ],
              ),
            ],
          ),
          // SizedBox(height: 4.h),
          const Divider(color: mainColor),
          // SizedBox(height: 4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.timer, size: 40.w),
              SizedBox(width: 8.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ضمان علي الخدمة',
                    style: titleBold(color: Colors.black, size: 14),
                  ),
                  Text(
                    'حتي 30 يوم من تاريخ إنتهاء الخدمة',
                    style: titleNormal(color: Colors.black, size: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
