import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/constants/spacing_and_sizes.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/screens/MainScreens/NavigationHome/body/cart_nav_icon.dart';
import 'package:sanaiey/screens/MainScreens/SettingsDrawer/settings_drawer.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/home_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/bottom_nav_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/main_loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';

import 'body/categories/canceled_orders.dart';
import 'body/categories/new_orders.dart';
import 'body/categories/previous_orders.dart';
import 'body/categories/waiting_orders.dart';
import 'body/order_item.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  bool canceledOrders = false;

  bool newOrders = true;
  int orderIndex = 0;
  bool previousOrders = false;
  bool tabledOrders = false;
  bool loadData = false;

  @override
  void initState() {
    super.initState();
    orderIndex = 0;
    getData();
  }

  Future<void> getData() async {
    await Get.find<OrderController>().getOrdersData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> orderTypeListViews = [
      const NewOrders(),
      const PreviousOrders(),
      const WaitingOrders(),
      const CanceledOrders(),
    ];
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      drawer: CustomCategoryDrawer(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            HomeAppBar(title: 'طلباتي'),
            // SizedBox(height: 40),
            Container(
              width: 414.w,
              height: 600.h,
              child: GetBuilder<OrderController>(
                builder: (orderController) => orderController.orderStage == OrderStage.LOADING
                    ? ScreenLoader()
                    : Reload(
                        load: () async {
                          await getData();
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(height: 8.h),
                              Container(
                                height: 40.h,
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                    orderController.ordersStatusList.length,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          orderIndex = index;
                                          loadData = true;
                                        });
                                        orderController.changeStatusId(
                                          id: '${orderController.ordersStatusList[index].id}',
                                        );
                                      },
                                      child: Container(
                                        height: 35.h,
                                        width: 90.w,
                                        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                                        decoration: decorationRadius(
                                          color: orderIndex == index ? mainColor : whiteColor,
                                          radius: defaultButtonRadius,
                                        ),
                                        child: Center(
                                          child: FittedBox(
                                            child: Text(
                                              '${orderController.ordersStatusList[index].statusName}',
                                              style: orderIndex == index
                                                  ? titleNormal(color: whiteColor, size: 14)
                                                  : titleNormal(color: mainColor, size: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                                color: mainColor,
                              ),
                              orderController.orderStatusStage == OrderStage.LOADING
                                  ? Center(
                                      child: SizedBox(
                                        height: 480.h,
                                        child: MainLoader(),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 480.h,
                                      child: ListView.builder(
                                        padding: EdgeInsets.only(bottom: 30.h),
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: orderController.ordersDetailsList.length,
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return orderItem(
                                            context: context,
                                            borderColor: index.isEven ? mainColor : secondaryColor,
                                            buttonText: index.isOdd ? "قيد التنفيذ" : "تم استلام الطلب ",
                                            buttonColor: index.isOdd ? secondaryColor : mainColor,
                                            orderItem: orderController.ordersDetailsList[index],
                                          );
                                        },
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CartNavIcon(),
    );
  }
}
