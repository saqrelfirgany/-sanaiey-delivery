import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/home_controller.dart';
import 'package:sanaiey/screens/MainScreens/SettingsDrawer/settings_drawer.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';

import '../../../Helper/decoration_helper.dart';
import '../../../Helper/route.dart';
import '../SelectAddress/select_address.dart';

class CartTermsScreen extends StatefulWidget {
  const CartTermsScreen({Key? key}) : super(key: key);

  @override
  _CartTermsScreenState createState() => _CartTermsScreenState();
}

class _CartTermsScreenState extends State<CartTermsScreen> {
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      drawer: CustomCategoryDrawer(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            BackAppBar(title: 'سياسة الخصوصية'),
            SizedBox(height: 8.h),
            Container(
              width: 414.w,
              height: 690.h,
              child: GetBuilder<HomeController>(
                builder: (homeController) => homeController.homeStage == HomeStage.LOADING
                    ? ScreenLoader()
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'سياسة الخصوصية',
                                style: titleNormal(color: mainColor, size: 18),
                                maxLines: 1000,
                                textAlign: TextAlign.start,
                                softWrap: true,
                              ),
                              SizedBox(
                                width: 100.w,
                                child: Divider(color: mainColor),
                              ),
                              Text(
                                '${homeController.aboutUsModel.privacyPolicy}',
                                style: titleNormal(color: Colors.black),
                                maxLines: 1000,
                                textAlign: TextAlign.start,
                                softWrap: true,
                              ),
                              SizedBox(height: 160.h),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () async {
          fadNavigate(Get.context!, SelectAddress());
        },
        child: Container(
          width: double.infinity,
          height: 50.h,
          margin: EdgeInsets.all(8.w),
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
