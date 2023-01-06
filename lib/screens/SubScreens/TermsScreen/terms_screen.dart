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

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsScreenState createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
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

                              SizedBox(height: 110.h),
                            ],
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
