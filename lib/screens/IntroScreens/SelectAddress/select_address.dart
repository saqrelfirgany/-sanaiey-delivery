import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/IntroControllers/select_address_controller.dart';
import 'package:sanaiey/screens/SharedComponents/loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';

import 'body/city_drop_down.dart';
import 'body/governorate_drop_down.dart';
import 'body/region_drop_down.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({Key? key}) : super(key: key);

  @override
  _SelectAddressScreenState createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Get.find<SelectAddressController>().getAddressData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: GetBuilder<SelectAddressController>(
        builder: (selectAddressController) => selectAddressController.addressStage == AddressStage.LOADING
            ? Center(child: ScreenLoader())
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 53.h),
                    Text(
                      'setYourLocation'.tr,
                      style: titleBold(color: Colors.black, size: 28),
                    ),
                    // SizedBox(height: 8.h),
                    Text(
                      'pleaseSetYourLocationAndStart'.tr,
                      style: titleNormal(color: Colors.black, size: 17),
                    ),
                    SizedBox(height: 8.h),
                    Image.asset(
                      'assets/images/set_location.png',
                      width: double.infinity,
                      height: 288.h,
                    ),
                    SizedBox(height: 18.h),

                    ///
                    /// First List
                    ///
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 36.w),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          'area'.tr,
                          style: titleBold(color: Colors.black, size: 12),
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    GetBuilder<SelectAddressController>(
                      builder: (controller) => GovernorateDropDown(
                        list: controller.governorateList,
                        press: controller.changeGovernorateId,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    ///
                    /// Area List
                    ///
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 36.w),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          'city'.tr,
                          style: titleBold(color: Colors.black, size: 12),
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    GetBuilder<SelectAddressController>(
                      builder: (controller) => controller.loadingCity
                          ? loader
                          : CityDropDown(
                              list: controller.cityList,
                              press: controller.changeCity,
                            ),
                    ),

                    ///
                    /// Area List
                    ///
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 36.w),
                        child: Text(
                          'region'.tr,
                          style: titleBold(color: Colors.black, size: 12),
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    GetBuilder<SelectAddressController>(
                      builder: (controller) => controller.loadingRegion
                          ? loader
                          : RegionDropDown(
                              list: controller.regionList,
                              press: controller.changeRegion,
                            ),
                    ),
                    SizedBox(height: 36.h),

                    ///
                    /// Confirm Button
                    ///
                    selectAddressController.updating
                        ? loader
                        : InkWell(
                            onTap: () {
                              selectAddressController.updateBranchIdByRegionId();
                            },
                            child: Container(
                              width: double.infinity,
                              height: 60.h,
                              margin: EdgeInsets.all(16.w),
                              decoration: decorationRadius().copyWith(
                                color: const Color(0xFFAE0910),
                              ),
                              child: Center(
                                child: Text(
                                  'confirm'.tr,
                                  style: titleNormal(color: Colors.white, size: 18),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
