import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/screens/SharedComponents/BottomNavBar/quantity_and_services_nav_bar.dart';

import '../../../Helper/fonts_helper.dart';
import '../../../controllers/MainControllers/department_controller.dart';
import '../../SharedComponents/loaders/screen_loader.dart';
import 'body/offer_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  DepartmentController departmentController = Get.find<DepartmentController>();

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    loadData();
  }

  void loadData() async {
    // departmentController.getServicesForSearch(searchValue: 'تركيب');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      // key: _drawerKey,
      // drawer: CustomCategoryDrawer(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60.h,
              padding: EdgeInsets.only(top: 6.h),
              margin: EdgeInsets.only(top: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    offset: const Offset(0, 0),
                    blurRadius: 4.0,
                  )
                ],
              ),
              child: TextFormField(
                controller: searchController,
                focusNode: _focusNodes[0],
                onTap: () {},
                decoration: InputDecoration(
                  hintText: 'البحث',
                  suffixIcon: IconButton(
                    color: _focusNodes[0].hasFocus ? mainColor : Colors.grey,
                    onPressed: () {
                      Navigator.pop(context);
                      departmentController.clearServicesList();
                    },
                    icon: const Icon(CupertinoIcons.forward),
                  ),
                  prefixIcon: IconButton(
                    color: _focusNodes[0].hasFocus ? mainColor : Colors.grey,
                    onPressed: () {
                      if (searchController.text.isEmpty) {
                        Navigator.pop(context);
                        departmentController.clearServicesList();
                      } else {
                        searchController.clear();
                        departmentController.clearServicesList();
                      }
                    },
                    icon: const Icon(CupertinoIcons.clear),
                  ),
                  hintStyle: titleNormal(color: const Color(0xFF989898)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
                onChanged: (val) {
                  if (val.length >= 3) {
                    departmentController.getServicesForSearch(searchValue: val);
                  } else {
                    departmentController.clearServicesList();
                  }
                },
                onEditingComplete: () {
                  if (searchController.text.isEmpty) {
                    departmentController.clearServicesList();
                  }
                },
              ),
            ),
            Container(
              width: 414.w,
              height: 600.h,
              child: GetBuilder<DepartmentController>(
                builder: (departmentController) =>
                departmentController.serviceStage == DepartmentStage.LOADING
                        ? ScreenLoader()
                        :
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            height: 736.h,
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 200.h),
                              physics: const BouncingScrollPhysics(),
                              children: List.generate(
                                departmentController.searchServicesList.length,
                                (index) => OfferCard(
                                  item: departmentController.searchServicesList[index],
                                  index: index,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: QuantityAndServicesNavBar(),
    );
  }
}
