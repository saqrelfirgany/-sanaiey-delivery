import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/fav_controller.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/controllers/MainControllers/subscriptions_controller.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/main_loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';
import 'package:sanaiey/screens/SharedComponents/net_image.dart';

class SubscriptionsProviderTimeScreen extends StatefulWidget {
  const SubscriptionsProviderTimeScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionsProviderTimeScreen> createState() => _SubscriptionsProviderTimeScreenState();
}

class _SubscriptionsProviderTimeScreenState extends State<SubscriptionsProviderTimeScreen> {
  late OrderController orderController;
  late FavController favController;
  late SubscriptionsController subscriptionsController;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  DatePickerController _controller = DatePickerController();
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
    await orderController.getEmployeeDetails();
    _selectedDay = _focusedDay;
    subscriptionsController.getProviderDetailsTime(
      date: _selectedDay,
      employeeId: orderController.employeeModel.id,
      clientSubscriptionId: subscriptionsController.clientSubscriptionId,
    );
  }

  List<Widget> _getEventsForDay(DateTime day) {
    return [
      Text('ssss'),
    ];
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
            BackAppBar(title: 'مقدم الخدمة'),
            // SizedBox(height: 40),
            Container(
              width: 414.w,
              height: 600.h,
              child: GetBuilder<OrderController>(
                builder: (orderController) => orderController.employeeStage == OrderStage.LOADING
                    ? const ScreenLoader()
                    : Reload(
                        load: () async {
                          await getData();
                        },
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 120.h,
                                  width: 414.w,
                                  // decoration: decorationRadius(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // width: 330.w,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                favController
                                                    .addEmployeeToFav(
                                                  employeeId: '${orderController.employeeModel.id}',
                                                )
                                                    .then((value) {
                                                  orderController.getEmployee();
                                                  favController.getFavEmployeeList();
                                                });
                                                setState(() {
                                                  orderController.employeeModel.isFavourite =
                                                      !orderController.employeeModel.isFavourite;
                                                });
                                              },
                                              child: Icon(
                                                orderController.employeeModel.isFavourite
                                                    ? CupertinoIcons.heart_fill
                                                    : CupertinoIcons.heart,
                                                color: Colors.red.shade900,
                                              ),
                                            ),
                                            Text(
                                              '${orderController.employeeModel.name}',
                                              style: titleBold(color: Colors.black),
                                            ),
                                            Text(
                                              '${orderController.employeeModel.title}',
                                              style: titleNormal(color: Colors.black, size: 14),
                                            ),
                                            SizedBox(height: 8.h),
                                            AbsorbPointer(
                                              absorbing: true,
                                              child: RatingBar(
                                                initialRating: double.parse(
                                                  '${orderController.employeeModel.rate}',
                                                ),
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 28.w,
                                                ratingWidget: RatingWidget(
                                                  full: Icon(
                                                    Icons.star_rounded,
                                                    color: Colors.red.shade900,
                                                  ),
                                                  half: Icon(
                                                    Icons.star_rounded,
                                                    color: Colors.red.shade900,
                                                  ),
                                                  empty: Icon(
                                                    Icons.star_border_rounded,
                                                    color: Colors.red.shade900,
                                                  ),
                                                ),
                                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 120.w,
                                        height: 120.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(28.r),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(28.r),
                                          child: NetImage(
                                            uri: 'http://${orderController.employeeModel.image}',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 24.h),
                                DatePicker(
                                  DateTime.now(),
                                  initialSelectedDate: DateTime.now(),
                                  selectionColor: Colors.black,
                                  selectedTextColor: Colors.white,
                                  controller: _controller,
                                  locale: 'ar',
                                  height: 90.h,
                                  onDateChange: (date) {
                                    setState(() {
                                      _selectedDay = date;
                                    });
                                    subscriptionsController.getProviderDetailsTime(
                                      date: _selectedDay,
                                      employeeId: orderController.employeeModel.id,
                                      clientSubscriptionId: subscriptionsController.clientSubscriptionId,
                                    );
                                  },
                                ),
                                SizedBox(height: 8.h),
                                GetBuilder<SubscriptionsController>(
                                  builder: (subscriptionsController) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      subscriptionsController.subscriptionsStage ==
                                              SubscriptionsStage.LOADING
                                          ? const SizedBox()
                                          : Text(
                                              'جدول الايام',
                                              style: cairoW600(color: Colors.black),
                                            ),
                                      SizedBox(height: 16.h),
                                      subscriptionsController.subscriptionsStage ==
                                              SubscriptionsStage.LOADING
                                          ? SizedBox(
                                              width: 414.w,
                                              height: 400.h,
                                              child: Center(child: MainLoader()),
                                            )
                                          : Padding(
                                              padding: EdgeInsetsDirectional.only(bottom: 0.h),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${subscriptionsController.providerDetailsTime.day}',
                                                    style: cairoW300(color: Colors.black, size: 14),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 50.h,
                                                    margin: EdgeInsets.symmetric(
                                                      horizontal: 8.w,
                                                      vertical: 8.h,
                                                    ),
                                                    decoration: decorationRadius(),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 8.w),
                                                        Container(
                                                          width: 6.w,
                                                          height: 40.h,
                                                          decoration: decorationRadius(
                                                            color: subscriptionsController
                                                                        .providerDetailsTime.status ==
                                                                    0
                                                                ? mainColor
                                                                : subscriptionsController
                                                                            .providerDetailsTime.status ==
                                                                        1
                                                                    ? Colors.red.shade900
                                                                    : Colors.green.shade800,
                                                          ),
                                                        ),
                                                        SizedBox(width: 8.w),
                                                        Expanded(
                                                          child: Text(
                                                            '${subscriptionsController.providerDetailsTime.requestCaption ?? ''}',
                                                            style: cairoW300(color: Colors.black, size: 14),
                                                          ),
                                                        ),
                                                        SizedBox(width: 8.w),
                                                        subscriptionsController.providerDetailsTime.canAdd
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _isLoading = true;
                                                                  });
                                                                  subscriptionsController
                                                                      .addUserSubscriptionFromProviderDetails(
                                                                    navigation: true,
                                                                    selectedDay: _selectedDay,
                                                                  )
                                                                      .then((value) {
                                                                    setState(() {
                                                                      _isLoading = false;
                                                                    });
                                                                  });
                                                                },
                                                                child: Container(
                                                                  width: 60.w,
                                                                  height: 40.h,
                                                                  margin:
                                                                      EdgeInsetsDirectional.only(end: 8.w),
                                                                  decoration: decorationRadius(
                                                                    color: mainColor,
                                                                    radius: 4,
                                                                  ),
                                                                  child: Center(
                                                                    child: _isLoading
                                                                        ? loaderWhite
                                                                        : Text(
                                                                            'اضافة',
                                                                            style: cairoW300(
                                                                                color: Colors.white,
                                                                                size: 12),
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
                                    ],
                                  ),
                                ),
                                SizedBox(height: 24.h),
                              ],
                            ),
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
