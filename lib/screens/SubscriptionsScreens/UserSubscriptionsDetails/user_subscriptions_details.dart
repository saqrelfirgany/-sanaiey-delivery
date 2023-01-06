import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/Models/MianModels/user_subscriptions_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/subscriptions_controller.dart';
import 'package:sanaiey/screens/MainScreens/SettingsDrawer/settings_drawer.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/confim_dialog.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';
import 'package:sanaiey/screens/SharedComponents/net_image.dart';
import 'package:sanaiey/screens/SubscriptionsScreens/UserSubscriptionCalendar/user_subscription_calendar.dart';

class UserSubscriptionDetailsScreen extends StatelessWidget {
  const UserSubscriptionDetailsScreen({Key? key, required this.subscription}) : super(key: key);
  final UserSubscriptionsModel subscription;

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
            BackAppBar(title: 'تفاصيل الباقة'),
            SizedBox(height: 8.h),
            Container(
              width: 414.w,
              height: 690.h,
              child: GetBuilder<SubscriptionsController>(
                builder: (subscriptionsController) =>
                    subscriptionsController.subscriptionsStage == SubscriptionsStage.LOADING
                        ? ScreenLoader()
                        : SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 374.w,
                                  // height: 200.h,
                                  decoration: decorationRadius(),
                                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.subscriptions, color: mainColor, size: 18),
                                            SizedBox(width: 8.w),
                                            Text(
                                              subscription.subscriptionName,
                                              style: titleNormal(color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(color: mainColor.withOpacity(.4)),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.r),
                                        child: Container(
                                          width: 120.w,
                                          height: 120.h,
                                          child: NetImage(uri: '${subscription.imageUrl}'),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 8.w),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '\u2022 ' + '${subscription.visitCountDescription}',
                                                  style: titleNormal(color: Colors.black, size: 14),
                                                ),
                                                Text(
                                                  '\u2022 ' + '${subscription.serviceName}',
                                                  style: titleNormal(color: Colors.black, size: 14),
                                                ),
                                                Text(
                                                  '\u2022 ' + '${subscription.address}',
                                                  style: titleNormal(color: Colors.black, size: 14),
                                                ),
                                                Text(
                                                  '\u2022 ' + '${subscription.phone}',
                                                  style: titleNormal(color: Colors.black, size: 14),
                                                ),
                                                Text(
                                                  '\u2022 ' + '${subscription.visitTime}',
                                                  style: titleNormal(color: Colors.black, size: 14),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(color: mainColor.withOpacity(.4)),
                                      Row(
                                        children: [
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            child: Container(
                                              // width: double.infinity,
                                              height: 30.h,
                                              alignment: Alignment.bottomCenter,
                                              decoration: decorationRadius(color: accentColor, radius: 6),
                                              child: Center(
                                                child: Text(
                                                  'تعديل',
                                                  style: cairoW300(color: Colors.white, size: 12),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 24.w),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                fadNavigate(context, UserSubscriptionCalenderScreen(subscription: subscription));
                                              },
                                              child: Container(
                                                // width: double.infinity,
                                                height: 30.h,
                                                alignment: Alignment.bottomCenter,
                                                decoration: decorationRadius(color: mainColor, radius: 6),
                                                child: Center(
                                                  child: Text(
                                                    'جدولة',
                                                    style: cairoW300(color: Colors.white, size: 12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 24.w),
                                          Expanded(
                                            child: GestureDetector(
                                              // onTap: () => ConfirmDialog(text: 'تأكيد الإلغاء ؟'),
                                              child: Container(
                                                // width: double.infinity,
                                                height: 30.h,
                                                alignment: Alignment.bottomCenter,
                                                decoration: decorationRadius(color: Colors.red.shade900, radius: 6),
                                                child: Center(
                                                  child: Text(
                                                    'إلغاء',
                                                    style: cairoW300(color: Colors.white, size: 12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                        ],
                                      ),
                                      SizedBox(height: 8.h),
                                    ],
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
