import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/controllers/MainControllers/subscriptions_controller.dart';
import 'package:sanaiey/screens/MainScreens/NavigationHome/body/cart_nav_icon.dart';
import 'package:sanaiey/screens/MainScreens/SettingsDrawer/settings_drawer.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/home_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/bottom_nav_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';

import '../../SharedComponents/Buttons/fav_button.dart';
import 'body/new_sub_item.dart';
import 'body/user_sub_item.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({Key? key}) : super(key: key);

  @override
  _SubscriptionsScreenState createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  bool services = true;
  bool serviceProviders = false;
  late SubscriptionsController subscriptionsController;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Get.find<SubscriptionsController>().getSubscriptionsData();
    Get.find<OrderController>().isTechnicalSelectionAllowed();
    subscriptionsController = await Get.find<SubscriptionsController>();
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
            HomeAppBar(title: 'الباقات'),
            SizedBox(height: 8.h),
            Container(
              width: 414.w,
              height: 690.h,
              child: GetBuilder<SubscriptionsController>(
                builder: (subscriptionsController) => subscriptionsController.subscriptionsStage ==
                        SubscriptionsStage.LOADING
                    ? ScreenLoader()
                    : Reload(
                        load: () async {
                          await getData();
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: FavButton(
                                      onTapButton: () {
                                        setState(() {
                                          services = true;
                                          serviceProviders = false;
                                        });
                                        // favController.getFavList();
                                      },
                                      buttonText: "باقاتك",
                                      // width: 220,
                                      isActive: services,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: FavButton(
                                      onTapButton: () {
                                        setState(() {
                                          serviceProviders = true;
                                          services = false;
                                        });
                                        // favController.getFavEmployeeList();
                                      },
                                      buttonText: "باقات جديدة",
                                      isActive: serviceProviders,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              services == true
                                  ? SizedBox(
                                      height: 480.h,
                                      child: ListView(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        padding: EdgeInsets.only(bottom: 30.h),
                                        children: List.generate(
                                          subscriptionsController.userSubscriptionsList.length,
                                          (index) => UserSubscriptionItem(
                                            subscription: subscriptionsController.userSubscriptionsList[index],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              serviceProviders
                                  ? Container(
                                      height: 480.h,
                                      width: 330.w,
                                      child: ListView(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        padding: EdgeInsets.only(bottom: 30.h),
                                        children: List.generate(
                                          subscriptionsController.subscriptionsList.length,
                                          (index) => NewSubscriptionItem(
                                            subscription: subscriptionsController.subscriptionsList[index],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              // SizedBox(height: 80.h),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CartNavIcon(),
    );
  }
}
