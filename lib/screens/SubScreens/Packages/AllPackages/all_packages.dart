import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';
import 'package:sanaiey/screens/MainScreens/DepartmentScreen/body/department_hearder.dart';
import 'package:sanaiey/screens/MainScreens/HomeScreen/home_screen.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';
import 'package:sanaiey/screens/SharedComponents/net_image.dart';
import 'package:sanaiey/screens/SubScreens/Packages/PackageDetails/package_details.dart';

class AllPackagesScreen extends StatefulWidget {
  const AllPackagesScreen({
    Key? key,
    this.title = 'خدمة النظافة المنزلية',
    this.description = '',
  }) : super(key: key);
  final String title;
  final String description;

  @override
  State<AllPackagesScreen> createState() => _AllPackagesScreenState();
}

class _AllPackagesScreenState extends State<AllPackagesScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Get.find<DepartmentController>().getDepartmentItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      body: Column(
        children: [
          BackAppBar(title: 'خدمات النظافة المنزلية'),
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
                          Expanded(
                            child: Container(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                  child: GridView(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.4,
                                      crossAxisSpacing: 4,
                                      mainAxisSpacing: 4,
                                    ),
                                    // itemCount: homeProvider.categoriesImages.length,
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    children: List.generate(
                                      // controller.expertsList.length,
                                      controller.departmentItemsList.length,
                                      (index) => Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                          vertical: 8.w,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            controller.changePackagesIndexAndUpdateList(index: index);
                                            controller.setPackagesDepartmentSub0Id(id: '${controller.departmentItemsList[index].dapartmentSub0Id}');
                                            fadNavigate(
                                              context,
                                              PackageDetails(
                                                title:
                                                    '${controller.departmentItemsList[index].departmentName}',
                                                description:
                                                    '${controller.departmentItemsList[index].description}',
                                              ),
                                            );
                                            // controller.setServiceId(
                                            //   id: '${controller.departmentSub0List[index].departmentId}',
                                            // );
                                            // controller.changeServiceIndexWithoutUpdate(i: index);
                                            // fadNavigate(
                                            //   context,
                                            //   ServicesScreen(
                                            //     text: widget.text,
                                            //     subText: widget.subText,
                                            //     description: widget.description,
                                            //   ),
                                            // );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(8.w),
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFFFFFFFF),
                                                  Color(0xFFF2F2F2),
                                                ],
                                                begin: AlignmentDirectional.topCenter,
                                                end: AlignmentDirectional.bottomCenter,
                                              ),
                                              borderRadius: BorderRadius.circular(10.r),
                                              border: Border.all(width: 1, color: Colors.grey.shade300),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.3),
                                                  offset: const Offset(0, 0),
                                                  blurRadius: 4.0,
                                                )
                                              ],
                                            ),
                                            child: NetImage(
                                              uri: '${controller.departmentItemsList[index].imageUrl}',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(height: 60.h),
                          // ServiceGuarantee(),
                          // SizedBox(height: 46.h),
                          // SingleChildScrollView(
                          //   physics: const BouncingScrollPhysics(),
                          //   child: Column(
                          //     children: [
                          //       SizedBox(height: 100.h),
                          //       DepartmentHeader(text: widget.title),
                          //       SizedBox(height: 24.h),
                          //
                          //     ],
                          //   ),
                          // ),
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
