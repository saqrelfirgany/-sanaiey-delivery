import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:sanaiey/Helper/dio_helper.dart';
import 'package:sanaiey/Helper/helper.dart';
import 'package:sanaiey/Models/MianModels/SubscriptionsServiceModel.dart';
import 'package:sanaiey/Models/MianModels/subscriptions_model.dart';
import 'package:sanaiey/Models/MianModels/user_subscriptions_model.dart';
import 'package:sanaiey/Models/SubModel/subscription_time_model.dart';
import 'package:sanaiey/controllers/MainControllers/navigation_controller.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/SuccessAlert.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/subscription_done.dart';

import 'order_controller.dart';

enum SubscriptionsStage { Normal, ERROR, LOADING, DONE }

class SubscriptionsController extends GetxController {
  SubscriptionsStage subscriptionsStage = SubscriptionsStage.Normal;

  Future<void> getSubscriptionsData() async {
    subscriptionsStage = SubscriptionsStage.LOADING;
    await getNewSubscriptions();
    await getUserSubscriptions();
    subscriptionsStage = SubscriptionsStage.DONE;
    update();
  }

  ///
  /// New Subscriptions
  ///
  List<SubscriptionsModel> _subscriptionsList = [];

  List<SubscriptionsModel> get subscriptionsList => _subscriptionsList;

  Future<void> getNewSubscriptions() async {
    dynamic response = await DioHelper.get(url: 'subscription/getsubscriptionlist');
    if (response == null || response == false) {
      subscriptionsStage = SubscriptionsStage.ERROR;
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _subscriptionsList.clear();
      for (var element in dynamicList) {
        _subscriptionsList.add(SubscriptionsModel.fromJson(element));
      }
    }
    subscriptionsStage = SubscriptionsStage.DONE;
    update();
  }

  ///
  /// Subscriptions Services
  ///
  String subscriptionsDepartmentId = '';

  void setSubscriptionsDepartmentId({required String id}) {
    subscriptionsDepartmentId = id;
  }

  ///
  /// Bool User  Subscriptions
  ///
  bool userSubscriptionFlag = false;
  bool userSubscriptionScheduler = false;

  void setUserSubscriptionsFlag({required bool flag}) {
    userSubscriptionFlag = flag;
  }

  String subscriptionsId = '';

  void setSubscriptionsId({required String id}) {
    subscriptionsId = id;
  }

  String clientSubscriptionId = '';

  void setClientSubscriptionId({required String id}) {
    clientSubscriptionId = id;
  }

  String subscriptionServiceId = '';

  void setSubscriptionServiceId({required String id}) {
    subscriptionServiceId = id;
  }

  String subscriptionTime = '';

  void setSubscriptionTime({required String time}) {
    subscriptionTime = time;
  }

  List<SubscriptionsServiceModel> _subscriptionsServiceList = [];

  List<SubscriptionsServiceModel> get subscriptionsServiceList => _subscriptionsServiceList;

  Future<void> getSubscriptionsServices() async {
    subscriptionsStage = SubscriptionsStage.LOADING;
    dynamic response = await DioHelper.get(url: 'subscription/getsubscriptionservicelist/$subscriptionsId');
    if (response == null || response == false) {
      subscriptionsStage = SubscriptionsStage.ERROR;
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _subscriptionsServiceList.clear();
      for (var element in dynamicList) {
        _subscriptionsServiceList.add(SubscriptionsServiceModel.fromJson(element));
      }
    }
    subscriptionsStage = SubscriptionsStage.DONE;
    update();
  }

  Future<void> addSubscription() async {
    dynamic response = await DioHelper.post(
      url: 'subscription/subscripe',
      data: {
        "SubscriptionId": subscriptionsId,
        "SubscriptionServiceId": subscriptionServiceId,
        "AddressId": Get.find<OrderController>().addressId,
        "PhoneId": Get.find<OrderController>().phoneId,
        if (Get.find<OrderController>().providerId.isNotEmpty)
          "EmployeeId": Get.find<OrderController>().providerId,
        "VisitTime": subscriptionTime,
      },
    );
    if (response == null || response == false) {
      return;
    } else {
      SubscriptionDialog(context: Get.context, text: '${response['message']}');
      update();
    }
  }

  Future<void> unSubscripe({required String id}) async {
    dynamic response = await DioHelper.post(
      url: 'Client/UnSubscripe?subscriptionId=$id',
    );
    if (response == null || response == false) {
      return;
    } else {
      getUserSubscriptions();
      update();
    }
  }

  Future<void> addUserSubscription({navigation = false}) async {
    dynamic response = await DioHelper.post(
      url: 'Request/AddCustom',
      data: {
        "ClientId": Helper.clientId,
        "ClientSubscriptionId": subscriptionsId,
        "AddressId": Get.find<OrderController>().addressId,
        "PhoneId": Get.find<OrderController>().phoneId,
        "EmployeeId": Get.find<OrderController>().providerId,
        "RequestTime": subscriptionTime,
      },
    );
    if (response == null || response == false) {
      return;
    } else {
      SuccessAlertDialog(
        context: Get.context,
        body: '${response['message']}',
        press: () {
          if (navigation) {
            Navigator.pop(Get.context!);
          } else {
            Get.find<NavigationController>().changeIndexFunction(3, Get.context!);
          }
        },
      );
      update();
    }
  }
  Future<void> addUserSubscriptionFromProviderDetails({navigation = false, required DateTime selectedDay}) async {
    var day = DateFormat('yyyy-MM-ddT').format(selectedDay);
    var time = DateFormat.Hms().format(DateTime.parse(subscriptionTime));
    dynamic response = await DioHelper.post(
      url: 'Request/AddCustom',
      data: {
        "ClientId": Helper.clientId,
        "ClientSubscriptionId": clientSubscriptionId,
        "AddressId": Get.find<OrderController>().addressId,
        "PhoneId": Get.find<OrderController>().phoneId,
        "EmployeeId": Get.find<OrderController>().providerId,
        "RequestTime": '$day$time',
      },
    );
    if (response == null || response == false) {
      return;
    } else {
      getProviderTime(date: selectedDay);
      update();
    }
  }

  ///
  /// User Subscriptions
  ///
  List<UserSubscriptionsModel> _userSubscriptionsList = [];

  List<UserSubscriptionsModel> get userSubscriptionsList => _userSubscriptionsList;

  Future<void> getUserSubscriptions() async {
    dynamic response = await DioHelper.get(url: 'Subscription/GetClientSubcriptionList');
    if (response == null || response == false) {
      subscriptionsStage = SubscriptionsStage.ERROR;
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _userSubscriptionsList.clear();
      for (var element in dynamicList) {
        _userSubscriptionsList.add(UserSubscriptionsModel.fromJson(element));
      }
    }
    subscriptionsStage = SubscriptionsStage.DONE;
    update();
  }

  ///
  /// Start Date
  ///
  var _startDate = DateFormat('yyyy/MM/dd').format(DateTime.now());

  get startDate => _startDate;

  void choseStartDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      locale: const Locale("ar", "AR"),
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2032),
    );
    if (pickedDate != null) {
      _startDate = DateFormat('yyyy/MM/dd').format(pickedDate);
      // getSubscriptionsTime();
    }
    update();
  }

  ///
  /// End Date
  ///
  var _endDate = DateFormat('yyyy/MM/dd').format(DateTime.now().add(Duration(days: 30)));

  get endDate => _endDate;

  void choseEndDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      locale: const Locale("ar", "AR"),
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2032),
    );
    if (pickedDate != null) {
      _endDate = DateFormat('yyyy/MM/dd').format(pickedDate);
      // getSubscriptionsTime();
    }
    update();
  }

  ///
  /// Get Time
  ///
  List<SubscriptionsTimeModel> _subscriptionsTimeList = [];

  List<SubscriptionsTimeModel> get subscriptionsTimeList => _subscriptionsTimeList;

  void removeSubscriptionsTimeList() {
    _subscriptionsTimeList.clear();
    update();
  }

  Future<void> getSubscriptionsTime() async {
    subscriptionsStage = SubscriptionsStage.LOADING;
    update();
    dynamic response = await DioHelper.get(
      url:
          'Request/GetClientCalender?startTime=$_startDate&endTime=$_endDate&departmentId$subscriptionsDepartmentId',
    );
    if (response == null || response == false) {
      subscriptionsStage = SubscriptionsStage.ERROR;
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _subscriptionsTimeList.clear();
      for (var element in dynamicList) {
        _subscriptionsTimeList.add(SubscriptionsTimeModel.fromJson(element));
      }
    }
    subscriptionsStage = SubscriptionsStage.DONE;
    update();
  }

  ///
  /// Provider calender
  ///
  List<SubscriptionsTimeModel> _providerTimeList = [];

  List<SubscriptionsTimeModel> get providerTimeList => _providerTimeList;

  Future<void> getProviderTime({date}) async {
    subscriptionsStage = SubscriptionsStage.LOADING;
    update();
    dynamic response = await DioHelper.get(
      url: 'Request/GetClientCalender?startTime=$date',
    );
    if (response == null || response == false) {
      subscriptionsStage = SubscriptionsStage.ERROR;
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _providerTimeList.clear();
      for (var element in dynamicList) {
        _providerTimeList.add(SubscriptionsTimeModel.fromJson(element));
      }
    }
    subscriptionsStage = SubscriptionsStage.DONE;
    update();
  }

  ///
  /// Provider Details calender
  ///
  SubscriptionsTimeModel _providerDetailsTime = SubscriptionsTimeModel();

  SubscriptionsTimeModel get providerDetailsTime => _providerDetailsTime;

  Future<void> getProviderDetailsTime({
    date,
    required employeeId,
    required String clientSubscriptionId,
  }) async {
    var day = DateFormat('yyyy-MM-dd').format(date);
    subscriptionsStage = SubscriptionsStage.LOADING;
    update();
    dynamic response = await DioHelper.get(
      url:
          'Request/GetemployeeDayCalender?employeeId=$employeeId&day=$day&clientSubscriptionId=$clientSubscriptionId',
    );
    if (response == null || response == false) {
      subscriptionsStage = SubscriptionsStage.ERROR;
      return;
    } else {
      if (response['data'] != null) {
        _providerDetailsTime = SubscriptionsTimeModel.fromJson(response['data'][0]);
      }
    }
    subscriptionsStage = SubscriptionsStage.DONE;
    update();
  }
}
