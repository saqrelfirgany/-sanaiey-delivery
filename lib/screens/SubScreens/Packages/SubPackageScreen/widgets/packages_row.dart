import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';
import 'package:sanaiey/controllers/MainControllers/pachages_controller.dart';

class PackagesRow extends StatefulWidget {
  const PackagesRow({Key? key}) : super(key: key);

  @override
  State<PackagesRow> createState() => _PackagesRowState();
}

class _PackagesRowState extends State<PackagesRow> {
  @override
  Widget build(BuildContext context) {
    int old = 0;
    int current = 0;

    return GetBuilder<DepartmentController>(
      builder: (controller) => controller.departmentItemsList.isEmpty
          ? Container()
          : Container(
              height: 70.h,
              padding: EdgeInsets.only(bottom: 12.h),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: List.generate(
                  controller.departmentItemsList.length,
                  (index) => Container(
                    height: 70.h,
                    margin: EdgeInsetsDirectional.only(
                      bottom: 16.h,
                      start: 4.w,
                      end: 4.w,
                    ),
                    child: controller.indexPackages == index
                        ? ElevatedButton(
                            onPressed: () {
                              controller.changePackagesIndexWithoutUpdateList(index: index);
                              // print('${packController.departmentRowList[index].departmentName}');
                              // packController.setDepartmentSub0Id(
                              //   id: '${packController.departmentRowList[index].departmentSub0Id}',
                              //   name: '${packController.departmentRowList[index].departmentSub0}',
                              // );
                            },
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Center(
                                child: Text(
                                  '${controller.departmentItemsList[index].departmentName}',
                                  style: titleNormal(color: Colors.white, size: 14),
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              // shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              fixedSize: Size(120.w, 50.h),
                              primary: const Color(0xFFAE0910),
                              onPrimary: Colors.white,
                              side: BorderSide(width: 1.2, color: const Color(0xFFAE0910)),
                              elevation: 6,
                            ),
                          )
                        : OutlinedButton(
                            onPressed: () {
                              controller.changePackagesIndexWithoutUpdateList(index: index);
                              controller.setPackagesDepartmentSub0Id(id: '${controller.departmentItemsList[index].dapartmentSub0Id}');
                              controller.getPackagesServiceList();
                              // print('${packController.departmentRowList[index].departmentName}');
                              // packController.setDepartmentSub0Id(
                              //   id: '${packController.departmentRowList[index].departmentSub0Id}',
                              //   name: '${packController.departmentRowList[index].departmentSub0}',
                              // );
                            },
                            child: FittedBox(
                              child: Text(
                                '${controller.departmentItemsList[index].departmentName}',
                                style: titleNormal(color: Colors.black, size: 15),
                              ),
                              fit: BoxFit.fill,
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              fixedSize: Size(120.w, 50.h),
                              primary: Colors.white,
                              onPrimary: Colors.grey.shade800,
                              side: BorderSide(width: 1.2, color: Colors.grey.shade300),
                              elevation: 6,
                            ),
                          ),
                  ),
                ),
              ),
            ),
    );
  }
}
