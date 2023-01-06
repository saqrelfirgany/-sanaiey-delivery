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
import 'package:sanaiey/screens/SharedComponents/loaders/main_loader.dart';
import 'package:sanaiey/screens/SubscriptionsScreens/SubscriptionsAddress/subscription_address.dart';
import 'package:sanaiey/utils/responsive.dart';

class UserSubscriptionCalenderScreen extends StatefulWidget {
  const UserSubscriptionCalenderScreen({Key? key, required this.subscription}) : super(key: key);
  final UserSubscriptionsModel subscription;

  @override
  State<UserSubscriptionCalenderScreen> createState() => _UserSubscriptionCalenderScreenState();
}

class _UserSubscriptionCalenderScreenState extends State<UserSubscriptionCalenderScreen> {
  late SubscriptionsController subscriptionsController;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    subscriptionsController = Get.find<SubscriptionsController>();
    subscriptionsController.removeSubscriptionsTimeList();
    // await subscriptionsController.getSubscriptionsTime();
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
            BackAppBar(title: 'جدول مواعيد طلباتك'),
            SizedBox(height: 8.h),
            Container(
              width: 414.w,
              height: 690.h,
              child: GetBuilder<SubscriptionsController>(
                builder: (subscriptionsController) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: width(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'من تاريخ',
                                      style: titleNormal(color: Colors.black),
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => subscriptionsController.choseStartDate(),
                                        child: Container(
                                          height: 46.h,
                                          // width: width(context) * .69,
                                          decoration: decorationRadius(color: backGroundColor),
                                          child: Center(
                                            child: Text(
                                              '${subscriptionsController.startDate}',
                                              style: titleNormal(color: greyColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: SizedBox(
                                width: width(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'الي تاريخ',
                                      style: titleNormal(color: Colors.black),
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => subscriptionsController.choseEndDate(),
                                        child: Container(
                                          height: 46.h,
                                          // width: width(context) * .69,
                                          decoration: decorationRadius(color: backGroundColor),
                                          child: Center(
                                            child: Text(
                                              '${subscriptionsController.endDate}',
                                              style: titleNormal(color: greyColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        GestureDetector(
                          onTap: () {
                            subscriptionsController.getSubscriptionsTime();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 40.h,
                            alignment: Alignment.bottomCenter,
                            // margin: EdgeInsets.all(8.w),
                            decoration: decorationRadius(color: mainColor, radius: 6),
                            child: Center(
                              child: Text(
                                'عرض',
                                style: cairoW300(color: Colors.white, size: 12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        subscriptionsController.subscriptionsStage == SubscriptionsStage.LOADING
                            ? const SizedBox()
                            : Text(
                                'جدول الايام',
                                style: cairoW600(color: Colors.black),
                              ),
                        SizedBox(height: 16.h),
                        subscriptionsController.subscriptionsStage == SubscriptionsStage.LOADING
                            ? SizedBox(
                                width: 414.w,
                                height: 400.h,
                                child: Center(child: MainLoader()),
                              )
                            : ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: 80.h),
                                physics: NeverScrollableScrollPhysics(),
                                children: List.generate(
                                  subscriptionsController.subscriptionsTimeList.length,
                                  (index) => Padding(
                                    padding: EdgeInsetsDirectional.only(bottom: 16.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${subscriptionsController.subscriptionsTimeList[index].day}',
                                          style: cairoW300(color: Colors.black, size: 14),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 50.h,
                                          margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                          decoration: decorationRadius(),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 8.w),
                                              Container(
                                                width: 6.w,
                                                height: 40.h,
                                                decoration: decorationRadius(
                                                  color: subscriptionsController
                                                              .subscriptionsTimeList[index].status ==
                                                          0
                                                      ? mainColor
                                                      : subscriptionsController
                                                                  .subscriptionsTimeList[index].status ==
                                                              1
                                                          ? Colors.red.shade900
                                                          : Colors.green.shade800,
                                                ),
                                              ),
                                              SizedBox(width: 8.w),
                                              Expanded(
                                                child: Text(
                                                  '${subscriptionsController.subscriptionsTimeList[index].requestCaption ?? ''}',
                                                  style: cairoW300(color: Colors.black, size: 14),
                                                ),
                                              ),
                                              SizedBox(width: 8.w),
                                              subscriptionsController.subscriptionsTimeList[index].canAdd
                                                  ? GestureDetector(
                                                      onTap: () => fadNavigate(
                                                        context,
                                                        SubscriptionsAddress(),
                                                      ),
                                                      child: Container(
                                                        width: 60.w,
                                                        height: 40.h,
                                                        margin: EdgeInsetsDirectional.only(end: 8.w),
                                                        decoration: decorationRadius(
                                                          color: mainColor,
                                                          radius: 4,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'اضافة',
                                                            style: cairoW300(color: Colors.white, size: 12),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
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
