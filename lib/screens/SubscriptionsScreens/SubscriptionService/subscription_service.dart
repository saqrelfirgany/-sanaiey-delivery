import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/controllers/MainControllers/subscriptions_controller.dart';
import 'package:sanaiey/screens/MainScreens/SettingsDrawer/settings_drawer.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';
import 'package:sanaiey/screens/SubscriptionsScreens/NewSubscriptionsDate/new_subscription_date.dart';
import 'package:sanaiey/screens/SubscriptionsScreens/SubscriptionsAddress/subscription_address.dart';

class SubscriptionsService extends StatefulWidget {
  const SubscriptionsService({Key? key}) : super(key: key);

  @override
  _SubscriptionsServiceState createState() => _SubscriptionsServiceState();
}

class _SubscriptionsServiceState extends State<SubscriptionsService> {
  late SubscriptionsController subscriptionsController;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Get.find<SubscriptionsController>().getSubscriptionsServices();
    subscriptionsController = Get.find<SubscriptionsController>();
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
            BackAppBar(title: 'الخدمات'),
            SizedBox(height: 8.h),
            Container(
              width: 414.w,
              height: 660.h,
              child: GetBuilder<SubscriptionsController>(
                builder: (subscriptionsController) =>
                    subscriptionsController.subscriptionsStage == SubscriptionsStage.LOADING
                        ? ScreenLoader()
                        : Reload(
                            load: () async {
                              await getData();
                            },
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Text(
                                      'اختيار الخدمة بناء على مساحة المنزل',
                                      style: cairoW600(color: mainColor, size: 16),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  ListView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: BouncingScrollPhysics(),
                                    children: List.generate(
                                      subscriptionsController.subscriptionsServiceList.length,
                                      (index) => GestureDetector(
                                        onTap: () async {
                                          subscriptionsController.setSubscriptionServiceId(
                                            id: '${subscriptionsController.subscriptionsServiceList[index].subscriptionServiceId}',
                                          );
                                          bool isAllow =
                                              await Get.find<OrderController>().isHaveMultipleAddresses();
                                          if (isAllow) {
                                            fadNavigate(context, SubscriptionsAddress());
                                          } else {
                                            fadNavigate(context, NewSubscriptionsDateScreen());
                                          }
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          // height: 120.h,
                                          // color: Colors.blue,
                                          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8),
                                          padding: EdgeInsets.all(8.w),
                                          decoration: decorationRadiusBorder(),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 260.w,
                                                // color: Colors.red,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${subscriptionsController.subscriptionsServiceList[index].serviceName}',
                                                      style: cairoW600(color: mainColor, size: 14),
                                                      maxLines: 1,
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    Text(
                                                      '${subscriptionsController.subscriptionsServiceList[index].serviceDescription}',
                                                      style: titleNormal(color: Colors.black, size: 13),
                                                      maxLines: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${subscriptionsController.subscriptionsServiceList[index].netPrice}/شهريا',
                                                    style: cairoW600(color: Colors.red.shade900),
                                                  ),
                                                  // SizedBox(height: 12.h),
                                                  Text(
                                                    '${subscriptionsController.subscriptionsServiceList[index].totalPrice}/شهريا',
                                                    style: cairoW400(color: mainColor, size: 12).copyWith(
                                                      decoration: TextDecoration.lineThrough,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Spacer(),
                                              // Container(
                                              //   color: backGroundColor,
                                              //   width: 26.w,
                                              //   child: Center(
                                              //     child: Image.asset(
                                              //       'assets/double-chevron.png',
                                              //       width: 28.w,
                                              //       height: 28.w,
                                              //       color: greyColor,
                                              //     ),
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 68.h),
                                ],
                              ),
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
