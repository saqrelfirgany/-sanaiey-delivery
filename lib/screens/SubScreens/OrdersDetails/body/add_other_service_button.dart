import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

import '../../../../controllers/MainControllers/department_controller.dart';
import '../update_order/DepartmentDetails/dep_details_screen.dart';

class AddOtherServicesButton extends StatelessWidget {
  const AddOtherServicesButton({
    Key? key,
    required this.id,
    required this.requestId,
    required this.departmentName,
  }) : super(key: key);
  final String id;
  final String requestId;
  final String departmentName;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Get.find<DepartmentController>().setDepartmentRowId(
          id: id,
        );
        Get.find<OrderController>().setRequestId(
          id: requestId,
        );
        fadNavigate(
          context,
          DepDetailsUpdateScreen(title: departmentName, description: departmentName,showBottomNav: false),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: width * .4,
            height: isLandscape(context) ? 2 * height * .04 : height * .04,
            color: backGroundColor,
            child: const Center(
              child: CustomText(text: "إضافة خدمات أخرى", textColor: secondaryColor),
            ),
          )
        ],
      ),
    );
  }
}
