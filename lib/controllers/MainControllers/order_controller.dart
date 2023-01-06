import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sanaiey/Helper/dio_helper.dart';
import 'package:sanaiey/Helper/helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/Models/MianModels/order_model.dart';
import 'package:sanaiey/Models/MianModels/order_status_model.dart';
import 'package:sanaiey/Models/MianModels/provider_model.dart';
import 'package:sanaiey/Models/SubModel/date_model.dart';
import 'package:sanaiey/Models/SubModel/employee_model.dart';
import 'package:sanaiey/Models/SubModel/order_details_model.dart';
import 'package:sanaiey/controllers/MainControllers/cart_controller.dart';
import 'package:sanaiey/controllers/MainControllers/subscriptions_controller.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/confirm_with_reason.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/done_order.dart';
import 'package:sanaiey/screens/SharedComponents/getsnack_bars.dart';
import 'package:sanaiey/screens/SubScreens/ChangeTime/change_time.dart';

import '../../Models/SubModel/track_order_model.dart';

enum OrderStage { Normal, ERROR, LOADING, DONE }

class OrderController extends GetxController {
  OrderStage orderStage = OrderStage.Normal;

  Future<void> getOrdersData() async {
    orderStage = OrderStage.LOADING;
    await getOrdersStatus();
    await getNewOrders();
    orderStage = OrderStage.DONE;
    update();
  }

  var _selectedDate = DateFormat('yyyy/MM/dd').format(DateTime.now());

  get selectedDate => _selectedDate;

  void choseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      locale: const Locale("ar", "AR"),
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2032),
    );
    if (pickedDate != null) {
      _selectedDate = DateFormat('yyyy/MM/dd').format(pickedDate);
      getTime();
    }
    update();
  }

  ///
  /// Available Time
  ///
  List<DateModel> _dateList = [];

  List<DateModel> get dateList => _dateList;
  bool getAll = false;

  Future<void> getTime() async {
    orderStage = OrderStage.LOADING;
    String clientSubscriptionId = Get.find<SubscriptionsController>().subscriptionsId;
    dynamic response = await DioHelper.get(
      url: '/cart/GetReservationAvailableTimes?'
          'selectedTime=$_selectedDate&getAll$getAll&clientSubscriptionId=$clientSubscriptionId',
    );
    print('saqr $response');
    if (response == null || response == false) {
      orderStage = OrderStage.ERROR;
      _dateList.clear();
      update();
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _dateList.clear();
      for (var element in dynamicList) {
        _dateList.add(DateModel.fromJson(element));
      }
    }
    orderStage = OrderStage.DONE;
    update();
  }

  Future<void> getSubscriptionTime() async {
    orderStage = OrderStage.LOADING;
    String subscriptionsDepartmentId = Get.find<SubscriptionsController>().subscriptionsDepartmentId;
    print('ssssssssss$subscriptionsDepartmentId');
    dynamic response = await DioHelper.get(
      url: 'Subscription/GetTimeList/$subscriptionsDepartmentId',
    );
    if (response == null || response == false) {
      orderStage = OrderStage.ERROR;
      _dateList.clear();
      update();
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _dateList.clear();
      for (var element in dynamicList) {
        _dateList.add(DateModel.fromJson(element));
      }
    }
    orderStage = OrderStage.DONE;
    update();
  }

  ///
  /// Available Service Providers
  ///
  List<ProviderModel> _providerList = [];

  List<ProviderModel> get providerList => _providerList;

  Future<void> getEmployee({departmentId, isNewSubscription}) async {
    print('saqr!!$departmentId');
    print('saqr!!$isNewSubscription');
    orderStage = OrderStage.LOADING;
    dynamic response = await DioHelper.get(
      url: 'Employee/GetAppList?selectedDate'
          '=$_dateId&departmentId=$departmentId',
    );
    if (response == null || response == false) {
      orderStage = OrderStage.ERROR;
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _providerList.clear();
      for (var element in dynamicList) {
        _providerList.add(ProviderModel.fromJson(element));
      }
    }
    orderStage = OrderStage.DONE;
    update();
  }

  Future<void> getEmployee2({departmentId, isNewSubscription}) async {
    print('saqr!!$departmentId');
    print('saqr!!$isNewSubscription');
    orderStage = OrderStage.LOADING;
    dynamic response = await DioHelper.get(
      url: 'Employee/GetAppList?selectedDate'
          '=$_dateId',
    );
    if (response == null || response == false) {
      orderStage = OrderStage.ERROR;
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _providerList.clear();
      for (var element in dynamicList) {
        _providerList.add(ProviderModel.fromJson(element));
      }
    }
    orderStage = OrderStage.DONE;
    update();
  }

  Future<void> getEmployeeForNewSubscription({departmentId, isNewSubscription}) async {
    print('saqr!!$departmentId');
    print('saqr!!$isNewSubscription');
    print('saqr!!$_cityId');
    orderStage = OrderStage.LOADING;
    dynamic response = await DioHelper.get(
      url: 'Employee/GetAppList?selectedDate'
          '=$_dateId&departmentId=$departmentId'
          '&isNewSubscription=$isNewSubscription&cityId=${_cityId}',
    );
    if (response == null || response == false) {
      orderStage = OrderStage.ERROR;
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _providerList.clear();
      for (var element in dynamicList) {
        _providerList.add(ProviderModel.fromJson(element));
      }
    }
    orderStage = OrderStage.DONE;
    update();
  }

  String _employeeID = '';
  String get  employeeID => _employeeID;

  void setEmployeeID({required String id}) {
    _employeeID = id;
    _providerId = id;
  }

  ///
  /// Get Employee
  ///
  EmployeeModel _employeeModel = EmployeeModel();

  EmployeeModel get employeeModel => _employeeModel;
  OrderStage employeeStage = OrderStage.Normal;

  Future<void> getEmployeeDetails() async {
    employeeStage = OrderStage.LOADING;
    dynamic response = await DioHelper.get(url: 'Employee/GetAppReviewList/$_employeeID');
    if (response == null || response == false) {
      employeeStage = OrderStage.ERROR;
      return;
    } else {
      _employeeModel = EmployeeModel.fromJson(response['data']);
    }
    employeeStage = OrderStage.DONE;
    update();
  }

  ///
  /// User Data
  ///
  var pickedLat, pickedLng;
  String _addressId = '';

  get addressId => _addressId;

  void setAddressId({required String id}) {
    _addressId = id;
  }

  String _cityId = '';

  get cityId => _cityId;

  void setCityId({required String id}) {
    _cityId = id;
  }

  String _phoneId = '';

  get phoneId => _phoneId;

  void setPhoneId({required String id}) {
    _phoneId = id;
  }

  String _dateId = '';

  get dateId => _dateId;

  void setDateId({required String id}) {
    _dateId = id;
  }

  String _providerId = '';

  get providerId => _providerId;

  void setProviderId({required String id}) {
    _providerId = id;
  }

  // aqr33{"statusCode":1,"statusDescreption":"Success","message":"تمت العملية بنجاح","totalCount":0,"aleartType":0,"data":{"requestId":21449,"requestCaption":"طلب رقم #21449","department":"الكهرباء","date":"2022-12-13","dayOfWeek":"الثلاثاء","time":"06:00 PM","services":"تغيير صاعد واحد دور, test","requestStatus":null},"isSuccess":true,"isFail":false}
  Future<void> addOrder() async {
    print('addOrder ClientId ${Helper.clientId}');
    print('addOrder AddressId ${_addressId}');
    print('addOrder PhoneId ${_phoneId}');
    print('addOrder EmployeeId ${_providerId}');
    print('addOrder RequestTime ${_dateId}');
    dynamic response = await DioHelper.post(
      url: 'Request/AddCustom',
      data: {
        "ClientId": Helper.clientId,
        "AddressId": _addressId,
        "PhoneId": _phoneId,
        "EmployeeId": _providerId,
        "RequestTime": _dateId,
      },
    );
    if (response == null || response == false) {
      return;
    } else {
      DoneOrderDialog(context: Get.context, Id: '${response['data']['requestId']}');
      Get.find<CartController>().getCart();
      update();
    }
  }

  ///
  /// Orders Status
  ///
  List<OrdersStatusModel> _ordersStatusList = [];

  List<OrdersStatusModel> get ordersStatusList => _ordersStatusList;

  Future<void> getOrdersStatus() async {
    orderStage = OrderStage.LOADING;
    dynamic response = await DioHelper.get(url: 'request/GetAppRequestStatusList');
    if (response == null || response == false) {
      orderStage = OrderStage.ERROR;
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _ordersStatusList.clear();
      for (var element in dynamicList) {
        _ordersStatusList.add(OrdersStatusModel.fromJson(element));
      }
      if (_ordersStatusList.isNotEmpty) {
        _statusId = '${_ordersStatusList[0].id}';
      }
      // await getNewOrders();
    }
    orderStage = OrderStage.DONE;
    update();
  }

  ///
  /// New Orders
  ///
  List<OrderModel> _ordersDetailsList = [];

  List<OrderModel> get ordersDetailsList => _ordersDetailsList;
  String _statusId = '';

  Future changeStatusId({required String id}) async {
    orderStatusStage = OrderStage.LOADING;
    update();
    _statusId = id;
    await getNewOrders();
    orderStatusStage = OrderStage.DONE;
    update();
  }

  OrderStage orderStatusStage = OrderStage.Normal;

  Future<void> getNewOrders() async {
    dynamic response = await DioHelper.get(url: 'Request/GetAppList?status=$_statusId');
    if (response == null || response == false) {
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _ordersDetailsList.clear();
      for (var element in dynamicList) {
        _ordersDetailsList.add(OrderModel.fromJson(element));
      }
    }
    update();
  }

  OrderDetailsModel _ordersDetailsModel = OrderDetailsModel();

  OrderDetailsModel get ordersDetailsModel => _ordersDetailsModel;

  /// Order Details Tracking Model
  OrderDetailsTrackingModel _orderDetailsTrackingModelList = OrderDetailsTrackingModel();

  OrderDetailsTrackingModel get orderDetailsTrackingModelList => _orderDetailsTrackingModelList;
  /// Order Details Tracking Model
  RequestTrackItemList requestTrackItem = RequestTrackItemList();

  String _orderDetailsId = '';

  Future setOrderDetailsId({required String id}) async {
    _orderDetailsId = id;
  }

  OrderStage orderDetailsStage = OrderStage.Normal;

  Future<void> getOrderDetails() async {
    orderDetailsStage = OrderStage.LOADING;

    dynamic response = await DioHelper.get(url: 'Request/GetAppDetails/$_orderDetailsId');
    if (response == null || response == false) {
      orderDetailsStage = OrderStage.ERROR;

      return;
    } else {
      _ordersDetailsModel = OrderDetailsModel.fromJson(response['data']);
      orderDetailsStage = OrderStage.DONE;
    }
    update();
  }

  Future<void> getOrderDetailsTracking() async {
    orderDetailsStage = OrderStage.LOADING;

    dynamic response = await DioHelper.get(url: 'Request/Gettracking/$_orderDetailsId');
    if (response == null || response == false) {
      orderDetailsStage = OrderStage.ERROR;

      return;
    } else {
      _orderDetailsTrackingModelList = OrderDetailsTrackingModel.fromJson(response['data']);
      // if(_orderDetailsTrackingModelList.selectedTrackId)
      final requestTrackItemList = _orderDetailsTrackingModelList.requestTrackItemList;
      if (requestTrackItemList != null) {
        requestTrackItemList.forEach((element) {
          if (element.id == _orderDetailsTrackingModelList.selectedTrackId) {
            requestTrackItem = element;
          }
        });
      }

      orderDetailsStage = OrderStage.DONE;
    }
    update();
  }

  Future<bool> updateOrderFromOrderDetails({
    required String serviceId,
    required String serviceQuantity,
  }) async {
    print('RequestId:$requestId');
    print('ServiceId:$serviceId');
    print('ServiceQuantity:$serviceQuantity');

    dynamic response = await DioHelper.post(
      url: 'Request/AddUpdateService',
      data: {
        'RequestId': '$requestId',
        'ServiceId': '$serviceId',
        'ServiceQuantity': '$serviceQuantity',
      },
    );
    if (response == null || response == false) {
      return false;
    } else {
      if (response['statusCode'] == 0) {
        return false;
      }
      _ordersDetailsModel = OrderDetailsModel.fromJson(response['data']);
      update();
      return true;
    }
  }

  bool isLoading = false;
  TextEditingController reasonController = TextEditingController();

  Future<void> cancelOrderDetails({required String id}) async {
    reasonController.clear();
    ConfirmReasonDialog(
      text: 'إلغاء الطلب',
      controller: reasonController,
      press: () async {
        if (reasonController.text.isEmpty) {
          showError(body: 'برجاء كتابة السبب اولا');
          return;
        }
        Navigator.pop(Get.context!);
        isLoading = true;
        update();
        dynamic response = await DioHelper.post(
          url: 'request/cancel?requestId=$id&reason=${reasonController.text}',
        );
        if (response == null || response == false) {
          isLoading = false;
          update();
          return;
        } else {
          await getNewOrders();
          Navigator.pop(Get.context!);
          isLoading = false;
          update();
        }
        isLoading = false;
        update();
      },
    );
    isLoading = false;
    update();
  }

  String requestId = '';

  void setRequestId({required String id}) {
    requestId = id;
  }

  Future<bool> addServiceToOrderDetails({
    required String serviceId,
    required String serviceQuantity,
  }) async {
    print('RequestId:$requestId');
    print('ServiceId:$serviceId');
    print('ServiceQuantity:$serviceQuantity');
    dynamic response = await DioHelper.post(
      url: 'Request/AddUpdateService',
      data: {
        'RequestId': '$requestId',
        'ServiceId': '$serviceId',
        'ServiceQuantity': '$serviceQuantity',
      },
    );
    if (response == null || response == false) {
      return false;
    } else {
      if (response['statusCode'] == 0) {
        return false;
      }
      _ordersDetailsModel = OrderDetailsModel.fromJson(response['data']);
      update();
      return true;
    }
  }

  Future<void> changeOrderTime() async {
    reasonController.clear();
    ConfirmReasonDialog(
      text: 'برجاء ادخال السبب والمتابعة',
      controller: reasonController,
      press: () async {
        if (reasonController.text.isEmpty) {
          showError(body: 'برجاء كتابة السبب اولا');
          return;
        }
        Navigator.pop(Get.context!);
        fadNavigate(Get.context!, ChangeTimeScreen());
      },
    );
    isLoading = false;
    update();
  }

  Future<void> confirmChangeOrderTime() async {
    print('requestId=$requestId');
    print('reason=${reasonController.text}');
    print('newTime=$_dateId');
    isLoading = true;
    update();

    dynamic response = await DioHelper.post(
      url: 'request/ChangeTime?requestId=$requestId&reason=${reasonController.text}&newTime=$_dateId',
    );
    if (response == null || response == false) {
      isLoading = false;
      update();
      return;
    } else {
      _orderDetailsId = requestId;
      await getOrderDetails();
      Navigator.pop(Get.context!);
      isLoading = false;
      update();
    }
  }

  Future<bool> isHaveMultipleAddresses() async {
    dynamic response = await DioHelper.get(url: 'client/IsHaveMultipleAddressesOrPhones');
    if (response == null || response == false) {
      return false;
    } else {
      bool isAllow = response['data'] ?? true;
      return isAllow;
    }
  }

  bool isAllow = false;

  Future<bool> isTechnicalSelectionAllowed() async {
    dynamic response = await DioHelper.get(url: 'Setting/IsTechnicalSelectionAllowed');
    if (response == null || response == false) {
      isAllow = true;
      return true;
    } else {
      isAllow = response['data'] ?? true;
      return true;
    }
  }
}
