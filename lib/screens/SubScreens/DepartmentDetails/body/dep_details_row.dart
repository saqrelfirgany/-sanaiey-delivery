import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';

class DepDetailsRow extends StatefulWidget {
  const DepDetailsRow({Key? key}) : super(key: key);

  @override
  State<DepDetailsRow> createState() => _DepDetailsRowState();
}

class _DepDetailsRowState extends State<DepDetailsRow> {
  @override
  Widget build(BuildContext context) {
    int old = 0;
    int current = 0;

    return GetBuilder<DepartmentController>(
      builder: (controller) => controller.departmentRowList.isEmpty
          ? Container()
          : Container(
              height: 34.h,
              padding: EdgeInsets.only(bottom: 0.h),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                children: List.generate(
                  controller.departmentRowList.length,
                  (index) => Container(
                    margin: EdgeInsetsDirectional.only(
                      bottom: 4.h,
                      start: 4.w,
                      end: 4.w,
                    ),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 3,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 60.h,
                        child: controller.index == index
                            ? ElevatedButton(
                                onPressed: () {
                                  controller.changeDepRowIndex(i: index);
                                  print('${controller.departmentRowList[index].departmentName}');
                                  controller.setDepartmentSub0Id(
                                    id: '${controller.departmentRowList[index].departmentSub0Id}',
                                    name: '${controller.departmentRowList[index].departmentSub0}',
                                  );
                                },
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Center(
                                    child: Text(
                                      '${controller.departmentRowList[index].departmentSub0}',
                                      style: titleNormal(color: Colors.white, size: 14),
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  fixedSize: Size(120.w, 50.h),
                                  primary: const Color(0xFFAE0910),
                                  onPrimary: Colors.white,
                                  // side: const BorderSide(width: 1.2, color: Colors.black),
                                  // elevation: 3,
                                ),
                              )
                            : OutlinedButton(
                                onPressed: () {
                                  controller.changeDepRowIndex(i: index);
                                  print('${controller.departmentRowList[index].departmentName}');
                                  controller.setDepartmentSub0Id(
                                    id: '${controller.departmentRowList[index].departmentSub0Id}',
                                    name: '${controller.departmentRowList[index].departmentSub0}',
                                  );
                                },
                                child: FittedBox(
                                  child: Text(
                                    '${controller.departmentRowList[index].departmentSub0}',
                                    style: titleNormal(color: Colors.black, size: 15),
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  fixedSize: Size(120.w, 50.h),
                                  primary: Colors.white,
                                  onPrimary: Colors.grey.shade800,
                                  // side: BorderSide(width: 1.2, color: Colors.grey.shade300),
                                  // elevation: 10,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
