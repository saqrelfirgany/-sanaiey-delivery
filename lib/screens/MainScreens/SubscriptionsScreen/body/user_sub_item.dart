import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/Models/MianModels/user_subscriptions_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/controllers/MainControllers/subscriptions_controller.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/confim_dialog.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/loader.dart';
import 'package:sanaiey/screens/SharedComponents/net_image.dart';
import 'package:sanaiey/screens/SubscriptionsScreens/UserSubscriptionCalendar/user_subscription_calendar.dart';
import 'package:sanaiey/screens/SubscriptionsScreens/UserSubscriptionsDetails/user_subscriptions_details.dart';

import '../../../SubscriptionsScreens/SubscriptionsAddress/subscription_address.dart';

class UserSubscriptionItem extends StatefulWidget {
  UserSubscriptionItem({Key? key, required this.subscription}) : super(key: key);
  final UserSubscriptionsModel subscription;

  @override
  State<UserSubscriptionItem> createState() => _UserSubscriptionItemState();
}

class _UserSubscriptionItemState extends State<UserSubscriptionItem> {
  bool isLoading = false;
  OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 374.w,
          // height: 200.h,
          decoration: decorationRadius(),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.subscriptions, color: mainColor, size: 18),
                    SizedBox(width: 8.w),
                    Text(
                      widget.subscription.subscriptionName,
                      style: cairoW600(color: mainColor, size: 14),
                    ),
                  ],
                ),
              ),
              Divider(color: mainColor.withOpacity(.4)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        width: 80.w,
                        height: 80.h,
                        child: NetImage(uri: '${widget.subscription.imageUrl}'),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\u2022 ' + widget.subscription.visitCountDescription,
                          style: titleNormal(color: Colors.black, size: 14),
                        ),
                        Text(
                          '\u2022 ' + widget.subscription.serviceName,
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
                    child: GestureDetector(
                      onTap: () {
                        fadNavigate(
                            context, UserSubscriptionDetailsScreen(subscription: widget.subscription));
                      },
                      child: Container(
                        // width: double.infinity,
                        height: 30.h,
                        alignment: Alignment.bottomCenter,
                        decoration: decorationRadius(color: accentColor, radius: 6),
                        child: Center(
                          child: Text(
                            'تفاصيل',
                            style: cairoW300(color: Colors.white, size: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.find<SubscriptionsController>().setSubscriptionsDepartmentId(
                          id: '${widget.subscription.departmentId}',
                        );
                        Get.find<SubscriptionsController>().setClientSubscriptionId(
                          id: '${widget.subscription.clientSubscriptionId}',
                        );
                        Get.find<SubscriptionsController>().setSubscriptionsId(
                          id: '${widget.subscription.subscriptionId}',
                        );
                        Get.find<SubscriptionsController>().setUserSubscriptionsFlag(
                          flag: true,
                        );
                        Get.find<SubscriptionsController>().userSubscriptionScheduler = true;
                        fadNavigate(
                          context,
                          UserSubscriptionCalenderScreen(
                            subscription: widget.subscription,
                          ),
                        );
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
                  SizedBox(width: 16.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.find<SubscriptionsController>().setSubscriptionsDepartmentId(
                          id: '${widget.subscription.departmentId}',
                        );
                        print('widget.subscription.clientSubscriptionId${widget.subscription.clientSubscriptionId}');
                        Get.find<SubscriptionsController>().setClientSubscriptionId(
                          id: '${widget.subscription.clientSubscriptionId}',
                        );
                        Get.find<SubscriptionsController>().setSubscriptionsId(
                          id: '${widget.subscription.subscriptionId}',
                        );
                        Get.find<SubscriptionsController>().setUserSubscriptionsFlag(
                          flag: true,
                        );
                        Get.find<SubscriptionsController>().userSubscriptionScheduler = false;
                        fadNavigate(context, SubscriptionsAddress());
                      },
                      child: Container(
                        // width: double.infinity,
                        height: 30.h,
                        alignment: Alignment.bottomCenter,
                        decoration: decorationRadius(color: mainColor, radius: 6),
                        child: Center(
                          child: Text(
                            'جدولة عاملة',
                            style: cairoW300(color: Colors.white, size: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => ConfirmDialog(
                        text: 'تأكيد الإلغاء ؟',
                        onConfirm: () {
                          Navigator.pop(context);
                          setState(() {
                            isLoading = true;
                          });
                          Get.find<SubscriptionsController>()
                              .unSubscripe(
                            id: '${widget.subscription.subscriptionId}',
                          )
                              .then((value) {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                      ),
                      child: Container(
                        // width: double.infinity,
                        height: 30.h,
                        alignment: Alignment.bottomCenter,
                        decoration: decorationRadius(color: Colors.red.shade900, radius: 6),
                        child: Center(
                          child: isLoading
                              ? Loader(color: Colors.white)
                              : Text(
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
        )
      ],
    );
  }
}
