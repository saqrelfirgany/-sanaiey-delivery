import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/screens/MainScreens/DepartmentScreen/body/department_hearder.dart';
import 'package:sanaiey/screens/MainScreens/HomeScreen/home_screen.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/BottomNavBar/quantity_and_services_nav_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/main_loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SubScreens/OffersScreen/body/offer_card.dart';

import '../../SharedComponents/net_image.dart';
import 'body/service_row.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({
    Key? key,
    required this.text,
    required this.subText,
    required this.description,
  }) : super(key: key);
  final String text;
  final String subText;
  final String description;

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    await Get.find<DepartmentController>().getServices();
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
            BackAppBar(title: 'الخدمات'),
            // SizedBox(height: 40),
            Container(
              width: 414.w,
              height: 600.h,
              child: GetBuilder<DepartmentController>(
                builder: (controller) => Reload(
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
                      DepartmentHeader(text: '${widget.text}'),
                      SizedBox(height: 16.h),

                      ///
                      /// Sub Title
                      ///
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: 8.w,
                      //     // vertical: 8.w,
                      //   ),
                      //   child: SizedBox(
                      //     width: 736.w,
                      //     child: Text(
                      //       widget.description,
                      //       maxLines: 2,
                      //       textAlign: TextAlign.center,
                      //       style: titleNormal(color: Colors.black, size: 14),
                      //     ),
                      //   ),
                      // ),

                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: 16.w,
                      //     vertical: 4.w,
                      //   ),
                      //   child: SizedBox(
                      //     width: 736.w,
                      //     child: Text(
                      //       widget.subText,
                      //       maxLines: 2,
                      //       textAlign: TextAlign.start,
                      //       style: titleNormal(color: Colors.black, size: 16),
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                      //   child: SizedBox(
                      //     width: 120.w,
                      //     child: const Divider(color: Colors.black),
                      //   ),
                      // ),
                      // SizedBox(height: 8.h),

                      ///
                      /// Row
                      ///
                      const ServiceRow(),
                      SizedBox(height: 8.h),
                      controller.serviceStage == DepartmentStage.LOADING
                          ? SizedBox(
                              width: double.infinity,
                              height: 200.h,
                              child: MainLoader(),
                            )
                          : Expanded(
                              child: Container(
                                height: 270.h,
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: ListView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: const BouncingScrollPhysics(),
                                    children: List.generate(
                                      controller.servicesList.length,
                                      (index) => OfferCard(
                                        item: controller.servicesList[index],
                                        index: index,
                                      ),
                                    )..add(
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(
                                            start: 16.w,
                                            end: 16.w,
                                            top: 24.h,
                                            bottom: 34.h,
                                          ),
                                          child: GetBuilder<UserController>(
                                            builder: (controller) => Container(
                                              height: 120,
                                              child: NetImage(
                                                uri: '${controller.serviceGuaranteeImage}',
                                                boxFit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: 36.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: QuantityAndServicesNavBar(),
    );
  }
}
