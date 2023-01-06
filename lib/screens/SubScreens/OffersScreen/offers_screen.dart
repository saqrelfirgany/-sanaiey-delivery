import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/home_controller.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/BottomNavBar/quantity_and_services_nav_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';

import 'body/offer_card.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await Get.find<HomeController>().getOfferItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      // key: _drawerKey,
      // drawer: CustomCategoryDrawer(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            BackAppBar(title: 'أحدث العروض'),
            // SizedBox(height: 40),
            Container(
              width: 414.w,
              height: 600.h,
              child: GetBuilder<HomeController>(
                builder: (controller) => controller.offerStage == HomeStage.LOADING
                    ? ScreenLoader()
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                              height: 736.h,
                              child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: 200.h),
                                physics: const BouncingScrollPhysics(),
                                children: List.generate(
                                  controller.offerItemsList.length,
                                  (index) => OfferCard(
                                    item: controller.offerItemsList[index],
                                    index: index,
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
      ),
      bottomNavigationBar: QuantityAndServicesNavBar(),
    );
  }
}
