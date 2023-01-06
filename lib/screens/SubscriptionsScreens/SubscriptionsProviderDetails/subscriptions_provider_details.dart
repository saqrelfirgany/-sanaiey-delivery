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
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/fav_controller.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/controllers/MainControllers/subscriptions_controller.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/main_loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';
import 'package:sanaiey/screens/SharedComponents/net_image.dart';
import 'package:sanaiey/screens/SubscriptionsScreens/SubscriptionsAddress/subscription_address.dart';

class SubscriptionsProviderDetailsScreen extends StatefulWidget {
  const SubscriptionsProviderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionsProviderDetailsScreen> createState() => _SubscriptionsProviderDetailsScreenState();
}

class _SubscriptionsProviderDetailsScreenState extends State<SubscriptionsProviderDetailsScreen> {
  late OrderController orderController;
  late FavController favController;
  late SubscriptionsController subscriptionsController;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  DatePickerController _controller = DatePickerController();

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
    subscriptionsController.getProviderTime(date: _selectedDay);
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
                                Text(
                                  'التقييمات',
                                  style: cairoW600(color: Colors.black),
                                ),
                                SizedBox(height: 8.h),
                                orderController.employeeModel.employeeReviews == null
                                    ? const SizedBox()
                                    : ListView(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics: BouncingScrollPhysics(),
                                        children: List.generate(
                                          orderController.employeeModel.employeeReviews!.length,
                                          (index) => Container(
                                            height: 80.h,
                                            padding: EdgeInsets.all(8.w),
                                            margin: EdgeInsets.only(bottom: 8.h),
                                            decoration: decorationRadius(color: backGroundColor),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 120.w,
                                                  alignment: AlignmentDirectional.centerStart,
                                                  child: FittedBox(
                                                    child: Text(
                                                      '${orderController.employeeModel.employeeReviews![index].clientName}',
                                                      style: titleNormal(color: Colors.black),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 58.h,
                                                    padding: EdgeInsets.all(8.w),
                                                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                                                    decoration: const BoxDecoration(
                                                      color: whiteColor,
                                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: 160.w,
                                                          child: Text(
                                                            '${orderController.employeeModel.employeeReviews![index].review}',
                                                            style:
                                                                titleNormal(color: Colors.black, size: 14),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Align(
                                                          alignment: AlignmentDirectional.bottomEnd,
                                                          child: AbsorbPointer(
                                                            absorbing: true,
                                                            child: RatingBar(
                                                              initialRating: double.parse(
                                                                  '${orderController.employeeModel.employeeReviews![index].rate}'),
                                                              direction: Axis.horizontal,
                                                              allowHalfRating: true,
                                                              itemCount: 5,
                                                              itemSize: 12.w,
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
                                                              itemPadding: EdgeInsets.symmetric(
                                                                horizontal: 4.0,
                                                              ),
                                                              onRatingUpdate: (rating) {
                                                                print(rating);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
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
