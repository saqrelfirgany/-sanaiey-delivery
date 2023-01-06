import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/fav_controller.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/controllers/MainControllers/subscriptions_controller.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/getsnack_bars.dart';
import 'package:sanaiey/screens/SharedComponents/loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/main_loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';
import 'package:sanaiey/screens/SharedComponents/net_image.dart';
import 'package:sanaiey/screens/SubscriptionsScreens/SubscriptionsProviderDetails/subscriptions_provider_details.dart';
import 'package:sanaiey/screens/SubscriptionsScreens/SubscriptionsProviderTime/subscriptions_provider_time.dart';
import 'package:url_launcher/url_launcher.dart';

class UserSubscriptionsProviderScreen extends StatefulWidget {
  const UserSubscriptionsProviderScreen({Key? key}) : super(key: key);

  @override
  State<UserSubscriptionsProviderScreen> createState() => _UserSubscriptionsProviderScreenState();
}

class _UserSubscriptionsProviderScreenState extends State<UserSubscriptionsProviderScreen> {
  late OrderController orderController;
  late FavController favController;
  late SubscriptionsController subscriptionsController;

  int _providerIndex = -1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    favController = Get.find<FavController>();
    orderController = Get.find<OrderController>();
    subscriptionsController = Get.find<SubscriptionsController>();
    if (subscriptionsController.userSubscriptionFlag) {
      await orderController.getEmployeeForNewSubscription(
        departmentId: '${Get.find<SubscriptionsController>().subscriptionsDepartmentId}',
        isNewSubscription: false,
      );
    } else {
      await orderController.getEmployeeForNewSubscription(
        departmentId: '${Get.find<SubscriptionsController>().subscriptionsDepartmentId}',
        isNewSubscription: true,
      );
    }

    _providerIndex = -1;
  }

  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri _phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunch(_phoneUri.toString())) await launch(_phoneUri.toString());
    } catch (error) {
      throw ("Cannot dial");
    }
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
            BackAppBar(title: 'اختيار مقدم الخدمة'),
            // SizedBox(height: 40),
            Container(
              width: 414.w,
              height: 600.h,
              child: GetBuilder<OrderController>(
                builder: (orderController) => orderController.orderStage == OrderStage.LOADING
                    ? const ScreenLoader()
                    : Reload(
                        load: () async {
                          await getData();
                        },
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8.h),
                              //
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Text(
                                  'اختر العاملة المفضلة',
                                  style: titleBold(color: mainColor),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              orderController.orderStage == OrderStage.LOADING
                                  ? SizedBox(
                                      width: double.infinity,
                                      height: 400.h,
                                      child: MainLoader(),
                                    )

                                  ///
                                  /// Provider List
                                  ///
                                  : providerList(orderController, context),
                              SizedBox(height: 60.h),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _isLoading
          ? Container(
              width: double.infinity,
              height: 50.h,
              margin: EdgeInsets.all(8.w),
              child: Center(
                child: loader,
              ),
            )
          : GestureDetector(
              onTap: () {
                if (_providerIndex == -1) {
                  showError(body: 'برجاء تحديد مقدم الخدمة');
                  return;
                }
                if (subscriptionsController.userSubscriptionFlag) {
                  if (subscriptionsController.userSubscriptionScheduler) {
                    setState(() {
                      _isLoading = true;
                    });
                    subscriptionsController.addUserSubscription().then((value) {
                      setState(() {
                        _isLoading = false;
                      });
                    });
                  } else {
                    fadNavigate(context, SubscriptionsProviderTimeScreen());
                  }
                } else {
                  subscriptionsController.addSubscription();
                }
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
                    subscriptionsController.userSubscriptionScheduler ? 'تأكيد الطلب' : 'متابعة',
                    style: titleNormal(color: Colors.white, size: 18),
                  ),
                ),
              ),
            ),
    );
  }

  SizedBox providerList(OrderController orderController, BuildContext context) {
    return SizedBox(
      // height: 480.h,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: List.generate(
          orderController.providerList.length,
          (index) => Padding(
            padding: EdgeInsets.all(8.w),
            child: PhysicalModel(
              color: Colors.white,
              elevation: 3,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _providerIndex = index;
                  });
                  orderController.setProviderId(
                    id: '${orderController.providerList[index].id}',
                  );
                  orderController.setEmployeeID(
                    id: '${orderController.providerList[index].id}',
                  );
                },
                child: Container(
                  height: 120.h,
                  width: 370.w,
                  decoration: decorationRadius(
                    color: _providerIndex == index ? backGroundColor : Colors.white,
                  ),
                  // margin: EdgeInsets.all(8.w),
                  padding: EdgeInsetsDirectional.only(
                    start: 16.w,
                    end: 16.w,
                    bottom: 8.w,
                    top: 8.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 310.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${orderController.providerList[index].name}',
                                      style: titleBold(color: Colors.black, size: 14),
                                    ),
                                    Text(
                                      '${orderController.providerList[index].title}',
                                      style: titleNormal(color: Colors.black, size: 12),
                                    ),
                                    SizedBox(height: 8.h),
                                    AbsorbPointer(
                                      absorbing: true,
                                      child: RatingBar(
                                        initialRating:
                                            double.parse('${orderController.providerList[index].rate}'),
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 20.w,
                                        ratingWidget: RatingWidget(
                                          full: Icon(Icons.star_rounded, color: Colors.red.shade900),
                                          half: Icon(Icons.star_rounded, color: Colors.red.shade900),
                                          empty:
                                              Icon(Icons.star_border_rounded, color: Colors.red.shade900),
                                        ),
                                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  width: 80.w,
                                  height: 80.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(28.r),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(28.r),
                                    child: NetImage(
                                      uri: 'http://${orderController.providerList[index].image}',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              orderController.providerList[index].showCalendar
                                  ? InkWell(
                                      onTap: () {
                                        orderController.setEmployeeID(
                                          id: '${orderController.providerList[index].id}',
                                        );
                                        fadNavigate(context, SubscriptionsProviderTimeScreen());
                                      },
                                      child: Container(
                                        width: 80,
                                        height: 20,
                                        decoration: decorationRadius(color: Color(0xFFBEBEBE)),
                                        child: FittedBox(
                                          child: Text(
                                            'جدول المواعيد',
                                            style: titleNormal(color: Color(0xFFAE0910)),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                width: orderController.providerList[index].showCalendar ? 16.w : 0.w,
                              ),
                              InkWell(
                                onTap: () {
                                  orderController.setEmployeeID(
                                    id: '${orderController.providerList[index].id}',
                                  );
                                  fadNavigate(context, SubscriptionsProviderDetailsScreen());
                                },
                                child: Container(
                                  width: 80,
                                  height: 20,
                                  decoration: decorationRadius(color: Color(0xFFBEBEBE)),
                                  child: FittedBox(
                                    child: Text(
                                      'تفاصيل',
                                      style: titleNormal(color: Color(0xFFAE0910)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              favController.addEmployeeToFav(
                                employeeId: '${orderController.providerList[index].id}',
                              );
                              setState(() {
                                orderController.providerList[index].isFavourite =
                                    !orderController.providerList[index].isFavourite;
                              });
                            },
                            child: Icon(
                              orderController.providerList[index].isFavourite
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              color: Colors.red.shade900,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          orderController.providerList[index].showContact
                              ? IconButton(
                                  onPressed: () =>
                                      launchPhoneDialer(orderController.providerList[index].phone),
                                  icon: Icon(Icons.call, color: Colors.red.shade900),
                                )
                              : const SizedBox(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
