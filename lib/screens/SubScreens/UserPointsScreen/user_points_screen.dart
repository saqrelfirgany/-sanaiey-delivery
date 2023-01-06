import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/screens/MainScreens/SettingsDrawer/settings_drawer.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/main_loader.dart';

import '../../../Helper/decoration_helper.dart';

class UserPointsScreen extends StatefulWidget {
  const UserPointsScreen({Key? key}) : super(key: key);

  @override
  _UserPointsScreenState createState() => _UserPointsScreenState();
}

class _UserPointsScreenState extends State<UserPointsScreen> {
  late UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    userController.getUserPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      drawer: CustomCategoryDrawer(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            BackAppBar(title: 'النقاط'),
            SizedBox(height: 8.h),
            Container(
              width: 414.w,
              height: 660.h,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    GetBuilder<UserController>(
                      builder: (userController) => userController.pointsStage == UserStage.LOADING
                          ? SizedBox(
                              width: double.infinity,
                              height: 600.h,
                              child: const MainLoader(),
                            )
                          : Container(
                              width: double.infinity,
                              // height: 500.h,
                              margin: EdgeInsetsDirectional.all(16.w),
                              // alignment: Alignment.center,
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.only(bottom: 80.h),
                                children: [
                                  Container(
                                    // height: 120.h,
                                    width: 120.w,
                                    margin: EdgeInsetsDirectional.all(8),
                                    padding: EdgeInsets.all(8),
                                    decoration: decorationRadius(),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            width: 200.w,
                                            child: Column(
                                              children: [
                                                Text(
                                                  'التاريخ',
                                                  style: titleNormal(color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            width: 200.w,
                                            child: Column(
                                              children: [
                                                Text(
                                                  'السبب',
                                                  style: titleNormal(color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            width: 200.w,
                                            child: Column(
                                              children: [
                                                Text(
                                                  'النقاط',
                                                  style: titleNormal(color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]..addAll(
                                    List.generate(
                                      userController.pointsList.length,
                                      (index) => Container(
                                        // height: 120.h,
                                        width: 120.w,
                                        margin: EdgeInsetsDirectional.all(8),
                                        padding: EdgeInsets.all(8),
                                        decoration: decorationRadius(),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                width: 200.w,
                                                child: Column(
                                                  children: [
                                                    FittedBox(
                                                      child: Text(
                                                        '${userController.pointsList[index].creationDate}',
                                                        style: titleNormal(color: Colors.black),
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                width: 200.w,
                                                child: Column(
                                                  children: [
                                                    FittedBox(
                                                      child: Text(
                                                        '${userController.pointsList[index].reason}',
                                                        style: titleNormal(color: Colors.black),
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                width: 200.w,
                                                child: Column(
                                                  children: [
                                                    FittedBox(
                                                      child: Text(
                                                        '${userController.pointsList[index].points}',
                                                        style: titleNormal(
                                                          color:
                                                              userController.pointsList[index].pointType ==
                                                                      1
                                                                  ? Colors.red
                                                                  : Colors.green.shade800,
                                                        ),
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ),
                            ),
                      // SizedBox(
                      //         height: 545.h,
                      //         child: ListView(
                      //           shrinkWrap: true,
                      //           physics: const BouncingScrollPhysics(),
                      //           padding: EdgeInsets.zero,
                      //           children: List.generate(
                      //             userController.pointsList.length,
                      //             (index) => Container(
                      //               margin: EdgeInsets.all(20),
                      //               decoration: decorationRadius(color: Colors.red),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
