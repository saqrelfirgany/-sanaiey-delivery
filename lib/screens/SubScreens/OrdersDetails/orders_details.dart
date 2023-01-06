import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/cart_controller.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/custom_widgets/custom_button.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/screens/MainScreens/CartScreen/body/single_bill_item.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/Buttons/fav_button.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/main_loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';

import 'body/add_other_service_button.dart';
import 'body/address_and_phne_data.dart';
import 'body/dashed_line.dart';
import 'body/order_card.dart';
import 'body/service_provider_data.dart';
import 'body/trackyour_order_tab.dart';

class OrdersDetailsScreen extends StatefulWidget {
  const OrdersDetailsScreen({Key? key}) : super(key: key);

  @override
  _OrdersDetailsScreenState createState() => _OrdersDetailsScreenState();
}

class _OrdersDetailsScreenState extends State<OrdersDetailsScreen> {
  bool services = true;
  bool serviceProviders = false;
  late CartController cartController;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    cartController = Get.find<CartController>();
    await Get.find<OrderController>().getOrderDetails();
    Get.find<OrderController>().getOrderDetailsTracking();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            BackAppBar(title: 'تتبع طلبك'),
            // SizedBox(height: 40),
            Container(
              width: 414.w,
              height: 600.h,
              child: GetBuilder<OrderController>(
                builder: (orderController) => orderController.orderDetailsStage == OrderStage.LOADING
                    ? ScreenLoader()
                    : Reload(
                        load: () async {
                          await getData();
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: FavButton(
                                        onTapButton: () {
                                          setState(() {
                                            services = true;
                                            serviceProviders = false;
                                          });
                                          // favController.getFavList();
                                        },
                                        buttonText: "حالة الطلب",
                                        // width: 220,
                                        isActive: services,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: FavButton(
                                        onTapButton: () {
                                          setState(() {
                                            serviceProviders = true;
                                            services = false;
                                          });
                                          // favController.getFavEmployeeList();
                                        },
                                        buttonText: "حالة الطلب",
                                        isActive: serviceProviders,
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                  ],
                                ),
                                SizedBox(height: 8.w),
                                Text(
                                  '${orderController.ordersDetailsModel.requestCaption}',
                                  style: titleNormal(color: mainColor),
                                ),
                                SizedBox(height: 8.w),
                                services == true
                                    ? Container(
                                        height: 500,
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Column(
                                            children: [
                                              orderController.ordersDetailsModel.requestServiceList == null
                                                  ? const SizedBox()
                                                  : ListView(
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      padding: EdgeInsets.zero,
                                                      children: List.generate(
                                                        orderController
                                                            .ordersDetailsModel.requestServiceList!.length,
                                                        (index) => OrderItem(
                                                          cartItem: orderController.ordersDetailsModel
                                                              .requestServiceList![index],
                                                          orderController: orderController,
                                                          requestId:
                                                              '${orderController.ordersDetailsModel.requestId}',
                                                        ),
                                                      ),
                                                    ),
                                              CustomSizedBox(
                                                percentageOfHeight: .02,
                                              ),
                                              if (orderController.ordersDetailsModel.showAddServiceButton)
                                                AddOtherServicesButton(
                                                  id: '${orderController.ordersDetailsModel.departmentId}',
                                                  requestId:
                                                      '${orderController.ordersDetailsModel.requestId}',
                                                  departmentName:
                                                      '${orderController.ordersDetailsModel.departmentName}',
                                                ),
                                              CustomSizedBox(
                                                percentageOfHeight: .02,
                                              ),
                                              DashedLine(),
                                              CustomSizedBox(
                                                percentageOfHeight: .02,
                                              ),
                                              AddressAndPhoneData(
                                                orderItem: orderController.ordersDetailsModel,
                                              ),
                                              CustomSizedBox(
                                                percentageOfHeight: .02,
                                              ),
                                              DashedLine(),
                                              CustomSizedBox(
                                                percentageOfHeight: .02,
                                              ),
                                              ServiceProviderData(
                                                orderItem: orderController.ordersDetailsModel,
                                              ),
                                              CustomSizedBox(
                                                percentageOfHeight: .02,
                                              ),
                                              DashedLine(),
                                              CustomSizedBox(
                                                percentageOfHeight: .02,
                                              ),
                                              Row(
                                                children: [
                                                  CustomText(
                                                    text: "تفاصيل الفاتورة",
                                                    fontWeight: FontWeight.bold,
                                                    textColor: blackColor,
                                                  ),
                                                ],
                                              ),
                                              orderController.ordersDetailsModel.invoiceDetails == null
                                                  ? const SizedBox()
                                                  : ListView(
                                                      scrollDirection: Axis.vertical,
                                                      shrinkWrap: true,
                                                      padding: EdgeInsets.zero,
                                                      physics: BouncingScrollPhysics(),
                                                      children: List.generate(
                                                        orderController
                                                            .ordersDetailsModel.invoiceDetails.length,
                                                        (index) => Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                                                          child: BillItem(
                                                            fieldName:
                                                                '${orderController.ordersDetailsModel.invoiceDetails.keys.elementAt(index)}',
                                                            fieldValue:
                                                                '${orderController.ordersDetailsModel.invoiceDetails.values.elementAt(index)}',
                                                            isTotal: index ==
                                                                orderController.ordersDetailsModel
                                                                        .invoiceDetails.length -
                                                                    1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              // BillDetailsData(),
                                              CustomSizedBox(
                                                percentageOfHeight: .02,
                                              ),
                                              DashedLine(),
                                              CustomSizedBox(
                                                percentageOfHeight: .02,
                                              ),
                                              orderController.isLoading
                                                  ? SizedBox(
                                                      height: 120.h,
                                                      child: MainLoader(),
                                                    )
                                                  : Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            if (orderController
                                                                .ordersDetailsModel.showReAssignEmployeeButton) CustomButton(
                                                              onTapButton: () {},
                                                              percentageOfWidth: .39,
                                                              buttonColor: secondaryColor,
                                                              textColor: whiteColor,
                                                              text: "طلب فني آخر",
                                                            ),
                                                            if (orderController
                                                                .ordersDetailsModel.showCancelRequestButton)
                                                              CustomButton(
                                                                onTapButton: () =>
                                                                    orderController.cancelOrderDetails(
                                                                  id: '${orderController.ordersDetailsModel.requestId}',
                                                                ),
                                                                percentageOfWidth: .49,
                                                                borderColor: secondaryColor,
                                                                buttonColor: whiteColor,
                                                                withBorders: true,
                                                                textColor: secondaryColor,
                                                                text: "إلغاء الطلب",
                                                              )
                                                          ],
                                                        ),
                                                        const CustomSizedBox(
                                                          percentageOfHeight: .02,
                                                        ),
                                                        if (orderController
                                                            .ordersDetailsModel.showDelayRequestButton) CustomButton(
                                                          onTapButton: () {
                                                            orderController.setRequestId(
                                                              id: '${orderController.ordersDetailsModel.requestId}',
                                                            );
                                                            orderController.changeOrderTime();
                                                          },
                                                          borderColor: secondaryColor,
                                                          buttonColor: whiteColor,
                                                          withBorders: true,
                                                          textColor: secondaryColor,
                                                          text: "تأجيل الموعد",
                                                        )
                                                      ],
                                                    ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : TrackYourOrderTap(
                                        requestTrackItem: orderController.requestTrackItem,
                                        orderDetails: orderController.ordersDetailsModel,
                                        orderDetailsTrackingModelList:
                                            orderController.orderDetailsTrackingModelList,
                                      ),
                                const CustomSizedBox(percentageOfHeight: .02),
                              ],
                            ),
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
