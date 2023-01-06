import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';
import 'package:sanaiey/screens/MainScreens/DepartmentScreen/body/department_hearder.dart';
import 'package:sanaiey/screens/MainScreens/HomeScreen/home_screen.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/main_loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';
import 'package:sanaiey/screens/SubScreens/Packages/SubPackageScreen/sub_package_screen.dart';
import 'package:sanaiey/screens/SubScreens/Packages/SubPackageScreen/widgets/packages_row.dart';

class PackageDetails extends StatefulWidget {
  const PackageDetails({
    Key? key,
    this.title = 'خدمة النظافة المنزلية',
    this.description = '',
  }) : super(key: key);
  final String title;
  final String description;

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Get.find<DepartmentController>().getPackagesServiceList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      body: Column(
        children: [
          BackAppBar(title: widget.title),
          // SizedBox(height: 40),
          Container(
            width: 414.w,
            height: 600.h,
            child: GetBuilder<DepartmentController>(
              builder: (controller) => controller.departmentStage == DepartmentStage.LOADING
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
                          DepartmentHeader(text: '${widget.title}'),
                          SizedBox(height: 24.h),
                          PackagesRow(),
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
                                        height: 130.h,
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
                                                    '${controller.departmentItemsList[controller.indexPackages].description}',
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
                                                controller.packagesServiceList.length,
                                                (index) => GestureDetector(
                                                  onTap: () {
                                                    controller.setPackagesServiceId(
                                                        id: '${controller.packagesServiceList[index].serviceId}');
                                                    fadNavigate(
                                                      context,
                                                      SubPackageScreen(
                                                        offerItemModel:
                                                            controller.packagesServiceList[index],
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
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.only(start: 16.w),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                '${controller.packagesServiceList[index].serviceName}',
                                                                style: titleBold(
                                                                    color: Colors.black, size: 14),
                                                              ),
                                                              Text(
                                                                '${controller.packagesServiceList[index].serviceCost} ج',
                                                                style: titleNormal(
                                                                    color: Colors.red, size: 14),
                                                              ),
                                                            ],
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
    );
  }
}
