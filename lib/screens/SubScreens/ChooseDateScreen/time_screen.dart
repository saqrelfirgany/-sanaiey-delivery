import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/getsnack_bars.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/main_loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SubScreens/ServiceProviderScreen/service_provider_screen.dart';
import 'package:sanaiey/utils/responsive.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({Key? key}) : super(key: key);

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  late OrderController orderController;
  int _dateIndex = -1;

  @override
  void initState() {
    super.initState();
    orderController = Get.find<OrderController>();
    getData();
  }

  Future getData() async {
    await orderController.getTime();
    _dateIndex = -1;
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
            BackAppBar(title: 'اختيار التوقيت'),
            // SizedBox(height: 40),
            Container(
              width: 414.w,
              height: 600.h,
              child: GetBuilder<OrderController>(
                builder: (orderController) => Reload(
                  load: () async {
                    await getData();
                  },
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          Text(
                            'اختر وقت الزيارة المفضل',
                            style: titleBold(color: mainColor),
                          ),
                          Text(
                            'وقت الزيارة يكون مقدم بساعتين',
                            style: titleNormal(color: mainColor),
                          ),
                          SizedBox(height: 16.h),
                          SizedBox(
                            width: width(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 46.h,
                                    // width: width(context) * .69,
                                    decoration: decorationRadius(color: backGroundColor),
                                    child: Center(
                                      child: Text(
                                        '${orderController.selectedDate}',
                                        style: titleNormal(color: greyColor),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.h),
                                Container(
                                  height: 46.h,
                                  width: 80.w,
                                  decoration: decorationRadius(color: backGroundColor),
                                  child: IconButton(
                                    onPressed: () => orderController.choseDate(),
                                    icon: Icon(Icons.date_range, color: mainColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          SizedBox(height: 8.h),
                          orderController.orderStage == OrderStage.LOADING
                              ? SizedBox(
                                  width: double.infinity,
                                  height: 282.h,
                                  child: MainLoader(),
                                )
                              : Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                                  child: GridView(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2.4,
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 0,
                                    ),
                                    // itemCount: homeProvider.categoriesImages.length,
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    children: List.generate(
                                      orderController.dateList.length,
                                      (index) => Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                          vertical: 8.w,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _dateIndex = index;
                                            });
                                            orderController.setDateId(
                                              id: '${orderController.dateList[index].time}',
                                            );
                                          },
                                          child: PhysicalModel(
                                            color: Colors.white,
                                            elevation: 3,
                                            borderRadius: BorderRadius.circular(10.r),
                                            child: Container(
                                              decoration: decorationRadius(
                                                color: _dateIndex == index ? backGroundColor : Colors.white,
                                              ),
                                              child: Center(
                                                child: FittedBox(
                                                  child: Text(
                                                    '${orderController.dateList[index].caption}',
                                                    style: titleNormal(color: Colors.black),
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(height: 40.h),
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
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (_dateIndex == -1) {
            showError(body: 'برجاء تحديد المعاد');
            return;
          }
          fadNavigate(context, ServiceProviderScreen());
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
              'متابعة الطلب',
              style: titleNormal(color: Colors.white, size: 18),
            ),
          ),
        ),
      ),
    );
  }
}
