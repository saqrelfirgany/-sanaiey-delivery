import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Models/SubModel/PackagesServiceModel.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/home_controller.dart';
import 'package:sanaiey/screens/MainScreens/SettingsDrawer/settings_drawer.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';

import '../../../../Helper/decoration_helper.dart';
import '../../../../Helper/route.dart';
import '../../../../controllers/MainControllers/order_controller.dart';
import '../../../../controllers/MainControllers/subscriptions_controller.dart';
import '../../../SubscriptionsScreens/SubscriptionService/subscription_service.dart';

class PackageConditionScreen extends StatelessWidget {
  PackageConditionScreen({
    Key? key,
    required this.body,
    required this.packagesServices,
  }) : super(key: key);
  final String body;
  SubscriptionsController subscriptionsController = Get.find<SubscriptionsController>();
  OrderController orderController = Get.find<OrderController>();
  final HomeSubscriptionsServiceModel packagesServices;

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
            BackAppBar(title: 'معلومات هامه'),
            SizedBox(height: 8.h),
            Container(
              width: 414.w,
              height: 690.h,
              child: GetBuilder<HomeController>(
                builder: (homeController) => homeController.homeStage == HomeStage.LOADING
                    ? ScreenLoader()
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                body,
                                style: titleNormal(color: Colors.black),
                                maxLines: 1000,
                                textAlign: TextAlign.start,
                                softWrap: true,
                              ),
                              SizedBox(height: 140.h),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          subscriptionsController.setSubscriptionsId(
            id: '${packagesServices.subscriptionId}',
          );
          subscriptionsController.setSubscriptionsDepartmentId(
            id: '${packagesServices.departmentId}',
          );
          subscriptionsController.setUserSubscriptionsFlag(
            flag: false,
          );
          orderController.getAll = true;
          fadNavigate(context, SubscriptionsService());
        },
        child: Container(
          width: double.infinity,
          height: 50.h,
          margin: EdgeInsets.all(16.w),
          decoration: decorationRadius().copyWith(
            color: const Color(0xFFAE0910),
          ),
          child: Center(
            child: Text(
              'تأكيد و متابعة',
              style: titleNormal(color: Colors.white, size: 18),
            ),
          ),
        ),
      ),
    );
  }
}
