import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/cart_controller.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';
import 'package:sanaiey/controllers/MainControllers/navigation_controller.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/controllers/MainControllers/subscriptions_controller.dart';
import 'package:sanaiey/screens/MainScreens/DepartmentScreen/body/department_hearder.dart';
import 'package:sanaiey/screens/MainScreens/HomeScreen/home_screen.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/BottomNavBar/quantity_and_services_nav_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/main_loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';

import '../../../../Models/MianModels/offer_item_model.dart';
import '../PackageCondition/package_condition.dart';

class SubPackageScreen extends StatefulWidget {
  const SubPackageScreen({Key? key, required this.offerItemModel}) : super(key: key);
  final OfferItemModel offerItemModel;

  @override
  State<SubPackageScreen> createState() => _SubPackageScreenState();
}

class _SubPackageScreenState extends State<SubPackageScreen> {
  bool monthlySubscription = true;
  bool orderAVisit = false;
  SubscriptionsController subscriptionsController = Get.find<SubscriptionsController>();
  OrderController orderController = Get.find<OrderController>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Get.find<DepartmentController>().getPackagesServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      body: Column(
        children: [
          GetBuilder<DepartmentController>(
            builder: (controller) => BackAppBar(
              title: '${controller.departmentItemsList[controller.indexPackages].departmentName}',
            ),
          ),
          // SizedBox(height: 40),
          Container(
            width: 414.w,
            height: 600.h,
            child: GetBuilder<DepartmentController>(
              builder: (controller) => controller.serviceStage == DepartmentStage.LOADING
                  ? const ScreenLoader()
                  : Reload(
                      load: () async {
                        await getData();
                      },
                      child: Column(
                        children: [
                          ///
                          /// Slider
                          ///
                          SizedBox(height: 8.h),
                          HomeSlider(),
                          SizedBox(height: 16.h),

                          ///
                          /// Department Header
                          ///
                          DepartmentHeader(
                            text:
                                '${controller.departmentItemsList[controller.indexPackages].departmentName}',
                          ),
                          SizedBox(height: 24.h),
                          // PackagesRow(),
                          // SizedBox(height: 16.h),

                          Expanded(
                            child: Container(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                                      child: SizedBox(
                                        width: double.infinity,
                                        // height: 130.h,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 74.h,
                                              width: 74.h,
                                              padding: EdgeInsets.all(8.w),
                                              child: Image.asset(
                                                'assets/icons/normal_cleaning.png',
                                                height: double.infinity,
                                                width: double.infinity,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${controller.departmentItemsList[controller.indexPackages].departmentName}',
                                                  style: titleBold(color: Colors.black),
                                                ),
                                                SizedBox(
                                                  width: 290.w,
                                                  // height: 80.h,
                                                  child: Text(
                                                    '${widget.offerItemModel.serviceName}',
                                                    style: titleNormal(color: Colors.black, size: 14),
                                                    maxLines: 3,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'يمكنك طلب زيارة واحدة',
                                                style: titleBold(color: Colors.black),
                                              ),
                                              Text(
                                                '${widget.offerItemModel.serviceCost} ج',
                                                style: titleBold(color: Colors.red.shade900),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                orderAVisit = true;
                                              });
                                              var isAdded = false;
                                              await Get.find<CartController>()
                                                  .updateCart(
                                                serviceId: '${widget.offerItemModel.serviceId}',
                                                quantity: '1',
                                              )
                                                  .then((value) {
                                                setState(() {
                                                  orderAVisit = false;
                                                });
                                                isAdded = value;
                                                if (isAdded) {
                                                  Get.find<NavigationController>()
                                                      .changeIndexFunction(2, context);
                                                }
                                              });
                                            },
                                            child: Container(
                                              width: 98.w,
                                              height: 46.h,
                                              margin: EdgeInsets.all(8.w),
                                              padding: EdgeInsets.all(8),
                                              decoration: decorationRadius().copyWith(
                                                color: const Color(0xFFAE0910),
                                              ),
                                              child: Center(
                                                child: orderAVisit
                                                    ? SizedBox(
                                                        width: 98.w,
                                                        height: 46.h,
                                                        child: Center(
                                                          child: Loader(color: Colors.white),
                                                        ),
                                                      )
                                                    : Text(
                                                        'اطلب الان',
                                                        style: titleNormal(color: Colors.white, size: 14),
                                                      ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    controller.packagesStage == DepartmentStage.LOADING
                                        ? MainLoader()
                                        : SizedBox(
                                            // height: 280.h,
                                            child: ListView(
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              padding: EdgeInsets.zero,
                                              children: List.generate(
                                                controller.packagesServicesList.length,
                                                (index) => GestureDetector(
                                                  onTap: () {
                                                    subscriptionsController.setSubscriptionsId(
                                                      id: '${controller.packagesServicesList[index].subscriptionId}',
                                                    );
                                                    subscriptionsController.setSubscriptionsDepartmentId(
                                                      id: '${controller.packagesServicesList[index].departmentId}',
                                                    );
                                                    subscriptionsController.setUserSubscriptionsFlag(
                                                      flag: false,
                                                    );
                                                    orderController.getAll = true;
                                                    // fadNavigate(context, SubscriptionsService());
                                                    fadNavigate(
                                                      context,
                                                      PackageConditionScreen(
                                                        body:
                                                            '${controller.packagesServicesList[index].condition}',
                                                          packagesServices:controller.packagesServicesList[index],
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 68.h,
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: 16.w, vertical: 6.h),
                                                    padding: EdgeInsets.all(4.w),
                                                    decoration: decorationRadius(),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: 320.w,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.only(start: 16.w),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  '${controller.packagesServicesList[index].subscriptionName}',
                                                                  style: titleBold(
                                                                      color: Colors.black, size: 14),
                                                                ),
                                                                Text(
                                                                  '${controller.packagesServicesList[index].description}',
                                                                  style: titleNormal(
                                                                      color: Colors.grey.shade600,
                                                                      size: 14),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.only(end: 4.w),
                                                          child: Icon(CupertinoIcons.forward, size: 34.w),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                    SizedBox(height: 24.h),
                                    // ServiceGuarantee(),
                                    // SizedBox(height: 60.h),
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
        ],
      ),
      bottomNavigationBar: QuantityAndServicesNavBar(),
    );
  }
}
