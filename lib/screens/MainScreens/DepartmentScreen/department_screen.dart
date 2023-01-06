import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';
import 'package:sanaiey/screens/MainScreens/HomeScreen/home_screen.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';

import 'body/department_card.dart';
import 'body/department_hearder.dart';

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Get.find<DepartmentController>().getDepartmentItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        extendBody: true,
          body: Column(
            children: [
              BackAppBar(title: 'الاقسام'),
              // SizedBox(height: 40),
              Container(
                width: 414.w,
                height: 600.h,
                child: GetBuilder<DepartmentController>(
                  builder: (controller) => controller.departmentStage == DepartmentStage.LOADING
                      ? const ScreenLoader()
                      : Reload(
                          load: () async {
                            await getData();
                          },
                          child: Column(
                            children: [
                              ///
                              /// Slider
                              ///
                              SizedBox(height: 8.h),
                              HomeSlider(),
                              SizedBox(height: 16.h),

                              ///
                              /// Department Header
                              ///
                              DepartmentHeader(text: '${widget.title}'),
                              SizedBox(height: 24.h),
                              Expanded(
                                child: Container(
                                  // height: 282.h,
                                  // color: Colors.blue,
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.zero,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: controller.departmentItemsList.length,
                                      itemBuilder: (context, index) {
                                        return DepartmentCard(
                                          item: controller.departmentItemsList[index],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        );

        // SingleChildScrollView(
        //   physics: const NeverScrollableScrollPhysics(),
        //   child: ,
        // ),

  }
}
