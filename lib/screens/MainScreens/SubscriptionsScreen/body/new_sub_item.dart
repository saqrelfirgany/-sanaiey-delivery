import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/Models/MianModels/subscriptions_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/controllers/MainControllers/subscriptions_controller.dart';
import 'package:sanaiey/screens/SubscriptionsScreens/SubscriptionService/subscription_service.dart';

class NewSubscriptionItem extends StatelessWidget {
  NewSubscriptionItem({Key? key, required this.subscription}) : super(key: key);
  final SubscriptionsModel subscription;
  SubscriptionsController subscriptionsController = Get.find<SubscriptionsController>();
  OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        subscriptionsController.setSubscriptionsId(
          id: '${subscription.subscriptionId}',
        );
        subscriptionsController.setSubscriptionsDepartmentId(
          id: '${subscription.departmentId}',
        );
        subscriptionsController.setUserSubscriptionsFlag(
          flag: false,
        );
        orderController.getAll = true;
        fadNavigate(context, SubscriptionsService());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: decorationRadius(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              // height: 110.h,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 8.h),
                  Text(
                    '${subscription.subscriptionName}',
                    style: titleNormal(color: Colors.white, size: 16),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'تبدأ من' ' ${subscription.startFromPriceC}',
                    style: titleNormal(color: Colors.white, size: 14),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: List.generate(
                subscription.specification.length,
                (index) => Column(
                  children: [
                    Text(
                      '${subscription.specification[index]}',
                      style: titleNormal(color: Colors.black, size: 14),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Divider(color: mainColor.withOpacity(.4)),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 30.h,
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: decorationRadius(color: Colors.red.shade900),
              child: Center(
                child: Text(
                  'اشتراك',
                  style: cairoW300(color: Colors.white, size: 13),
                ),
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
