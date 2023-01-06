import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';

class ServiceRow extends StatefulWidget {
  const ServiceRow({Key? key}) : super(key: key);

  @override
  State<ServiceRow> createState() => _ServiceRowState();
}

class _ServiceRowState extends State<ServiceRow> {
  @override
  Widget build(BuildContext context) {
    int old = 0;
    int current = 0;

    return GetBuilder<DepartmentController>(
      builder: (controller) => controller.departmentSub0List.isEmpty
          ? Container()
          : Container(
              height: 34.h,
              padding: EdgeInsets.only(bottom: 0.h),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: List.generate(
                  controller.departmentSub0List.length,
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
                        child: controller.indexService == index
                            ? ElevatedButton(
                                onPressed: () {
                                  controller.changeServiceIndex(i: index);
                                  controller.setServiceId(
                                    id: '${controller.departmentSub0List[index].departmentId}',
                                  );
                                },
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Center(
                                    child: Text(
                                      '${controller.departmentSub0List[index].departmentSub1}',
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
                                  // elevation: 10,
                                ),
                              )
                            : OutlinedButton(
                                onPressed: () {
                                  controller.changeServiceIndex(i: index);
                                  controller.setServiceId(
                                    id: '${controller.departmentSub0List[index].departmentId}',
                                  );
                                },
                                child: FittedBox(
                                  child: Text(
                                    '${controller.departmentSub0List[index].departmentSub1}',
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
