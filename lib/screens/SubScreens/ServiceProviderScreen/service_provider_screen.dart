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
import 'package:sanaiey/screens/MainScreens/OrderScreens/service_provider_details/service_provider_details_screen.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/getsnack_bars.dart';
import 'package:sanaiey/screens/SharedComponents/loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/main_loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';
import 'package:sanaiey/screens/SharedComponents/net_image.dart';

class ServiceProviderScreen extends StatefulWidget {
  const ServiceProviderScreen({Key? key}) : super(key: key);

  @override
  State<ServiceProviderScreen> createState() => _ServiceProviderScreenState();
}

class _ServiceProviderScreenState extends State<ServiceProviderScreen> {
  late OrderController orderController;
  late FavController favController;

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
    await orderController.getEmployee2();
    _providerIndex = -1;
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
                                  'اختر مزود الخدمة',
                                  style: titleBold(color: mainColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Text(
                                  'تمت مطابقة طلبك مع مزودي الخدمة الأنسب لك',
                                  style: titleNormal(color: mainColor),
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
                setState(() {
                  _isLoading = true;
                });
                orderController.addOrder().then((value) {
                  setState(() {
                    _isLoading = false;
                  });
                });
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
                    'تأكيد الطلب',
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
                            width: 330.w,
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
                                  width: 90.w,
                                  height: 90.w,
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
                          InkWell(
                            onTap: () {
                              orderController.setEmployeeID(
                                id: '${orderController.providerList[index].id}',
                              );
                              fadNavigate(context, ServiceProviderDetailsScreen());
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
                          )
                        ],
                      ),
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
