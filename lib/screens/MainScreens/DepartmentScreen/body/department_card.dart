import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/Models/MianModels/department_item_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/screens/SharedComponents/getsnack_bars.dart';
import 'package:sanaiey/screens/SharedComponents/net_image.dart';
import 'package:sanaiey/screens/SubScreens/DepartmentDetails/dep_details_screen.dart';
import 'package:sanaiey/utils/responsive.dart';

class DepartmentCard extends StatelessWidget {
  const DepartmentCard({Key? key, required this.item}) : super(key: key);
  final DepartmentItemModel item;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (!item.isActive) {
              showError(body: 'هذا القسم غير متاح الان, قريبا');
              return;
            }
            Get.find<DepartmentController>().setDepartmentRowId(
              id: '${item.departmentId}',
            );
            fadNavigate(
              context,
              DepDetailsScreen(
                title: '${item.departmentName}',
                description: '${item.description}',
              ),
            );
          },
          child: SizedBox(
            width: width * .9,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: width * .9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: width * .1),
                      Neumorphic(
                        child: Row(
                          children: [
                            Container(
                              width: width * .7,
                              color: whiteColor,
                              height: isLandscape(context) ? 2 * height * .12 : height * .12,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: width * .1),
                                      SizedBox(
                                        width: width * .6,
                                        child: Text(
                                          '${item.departmentName}',
                                          maxLines: 1,
                                          style: titleBold(color: Colors.black, size: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: width * .1),
                                      SizedBox(
                                        width: width * .6,
                                        child: Text(
                                          '${item.description}',
                                          maxLines: 1,
                                          style: titleNormal(color: Colors.grey, size: 14),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              color: backGroundColor,
                              width: width * .1,
                              height: isLandscape(context) ? 2 * height * .12 : height * .12,
                              child: Center(
                                child: Image.asset(
                                  'assets/double-chevron.png',
                                  width: 28.w,
                                  height: 28.w,
                                  color: greyColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Neumorphic(
                      child: Container(
                        width: width * .18,
                        height: isLandscape(context) ? 2 * height * .09 : height * .09,
                        decoration: BoxDecoration(
                          color: backGroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: NetImage(uri: '${item.imageUrl}'),
                      ),
                    ),
                    const SizedBox()
                  ],
                )
              ],
            ),
          ),
        ),
        const CustomSizedBox()
      ],
    );
  }
}
