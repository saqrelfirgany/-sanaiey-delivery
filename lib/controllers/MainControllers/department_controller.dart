import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sanaiey/Helper/dio_helper.dart';
import 'package:sanaiey/Models/MianModels/dep_row_model.dart';
import 'package:sanaiey/Models/MianModels/dep_sub0_model.dart';
import 'package:sanaiey/Models/MianModels/department_item_model.dart';
import 'package:sanaiey/Models/MianModels/offer_item_model.dart';
import 'package:sanaiey/Models/SubModel/PackagesServiceModel.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';

import 'home_controller.dart';

enum DepartmentStage { Normal, ERROR, LOADING, DONE }

class DepartmentController extends GetxController {
  DepartmentStage departmentStage = DepartmentStage.Normal;

  int _index = 0;

  get index => _index;

  void changeDepRowIndex({required int i}) {
    _index = i;
    update();
  }

  void changeDepRowIndexWithoutUpdate({required int i}) {
    _index = i;
  }

  int _indexService = 0;

  get indexService => _indexService;

  void changeServiceIndex({required int i}) {
    _indexService = i;
    update();
  }

  void changeServiceIndexWithoutUpdate({required int i}) {
    _indexService = 0;
    var item = _departmentSub0List.removeAt(i);
    _departmentSub0List.insert(0, item);
    update();
  }

  ///
  /// Home Department
  ///
  String _departmentId = '';

  void setDepartmentId({required String id}) {
    _departmentId = id;
  }

  List<DepartmentItemModel> _departmentItemsList = [];

  List<DepartmentItemModel> get departmentItemsList => _departmentItemsList;

  Future<void> getDepartmentItems() async {
    departmentStage = DepartmentStage.LOADING;
    await Get.find<HomeController>().getSlider();
    dynamic response = await DioHelper.get(url: '/AppLandingScreen/GetItemList/$_departmentId');
    if (response == null || response == false) {
      departmentStage = DepartmentStage.ERROR;
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _departmentItemsList.clear();
      for (var element in dynamicList) {
        _departmentItemsList.add(DepartmentItemModel.fromJson(element));
      }
    }
    departmentStage = DepartmentStage.DONE;
    update();
  }

  ///
  /// Home Packages
  ///
  int _indexPackages = 0;

  get indexPackages => _indexPackages;

  Future changePackagesIndexAndUpdateList({required int index}) async {
    _indexPackages = 0;
    var item = _departmentItemsList.removeAt(index);
    _departmentItemsList.insert(0, item);
    update();
  }

  void changePackagesIndexWithoutUpdateList({required int index}) {
    _indexPackages = index;
    update();
  }

  String _packagesDepartmentSub0Id = '';

  void setPackagesDepartmentSub0Id({required String id}) {
    _packagesDepartmentSub0Id = id;
  }

  List<OfferItemModel> _packagesServiceList = [];

  List<OfferItemModel> get packagesServiceList => _packagesServiceList;
  DepartmentStage packagesStage = DepartmentStage.Normal;

  Future<void> getPackagesServiceList() async {
    packagesStage = DepartmentStage.LOADING;
    await Get.find<HomeController>().getSlider();
    dynamic response = await DioHelper.get(
      url: 'Service/GetServiceList?departmentSub0Id=$_packagesDepartmentSub0Id',
    );
    if (response == null || response == false) {
      packagesStage = DepartmentStage.ERROR;
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _packagesServiceList.clear();
      for (var element in dynamicList) {
        _packagesServiceList.add(OfferItemModel.fromJson(element));
      }
    }
    packagesStage = DepartmentStage.DONE;
    update();
  }

  ///
  /// Packages Services List
  ///
  List<HomeSubscriptionsServiceModel> _packagesServicesList = [];

  List<HomeSubscriptionsServiceModel> get packagesServicesList => _packagesServicesList;
  String _packagesServicesId = '';

  void setPackagesServiceId({required String id}) {
    _packagesServicesId = id;
  }

  DepartmentStage serviceStage = DepartmentStage.Normal;

  Future<void> getPackagesServices() async {
    serviceStage = DepartmentStage.LOADING;
    await Get.find<HomeController>().getSlider();
    dynamic response = await DioHelper.get(
      url: 'Subscription/GetSubscriptionListByService/$_packagesServicesId',
    );
    if (response == null || response == false) {
      serviceStage = DepartmentStage.ERROR;
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _packagesServicesList.clear();
      for (var element in dynamicList) {
        _packagesServicesList.add(HomeSubscriptionsServiceModel.fromJson(element));
      }
    }
    serviceStage = DepartmentStage.DONE;
    update();
  }

  ///
  /// Department Level 1
  ///
  String _departmentRowId = '';

  void setDepartmentRowId({required String id}) {
    _departmentRowId = id;
  }

  List<DepartmentRowModel> _departmentRowList = [];

  List<DepartmentRowModel> get departmentRowList => _departmentRowList;
  DepartmentStage depLev1Stage = DepartmentStage.Normal;

  Future<void> getDepartmentRowItems() async {
    depLev1Stage = DepartmentStage.LOADING;
    await Get.find<HomeController>().getSlider();
    dynamic response =
        await DioHelper.get(url: '/department/GetDepartmentSub0List?departmentId=$_departmentRowId');
    if (response == null || response == false) {
      depLev1Stage = DepartmentStage.ERROR;
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _departmentRowList.clear();
      for (var element in dynamicList) {
        _departmentRowList.add(DepartmentRowModel.fromJson(element));
      }
    }
    if (_departmentRowList.isNotEmpty) {
      _departmentSub0Id = '${_departmentRowList[0].departmentSub0Id}';
      getDepartmentSub0Items();
    }
    depLev1Stage = DepartmentStage.DONE;
    update();
  }

  ///
  /// Department Sub0 Id
  ///
  String _departmentSub0Id = '';
  String departmentSub0 = '';

  void setDepartmentSub0Id({required String id, required String name}) {
    _departmentSub0Id = id;
    departmentSub0 = name;
    getDepartmentSub0Items();
  }

  List<DepSub0Model> _departmentSub0List = [];

  List<DepSub0Model> get departmentSub0List => _departmentSub0List;

  void changeIndex({required int i}) {
    var item = _departmentSub0List.removeAt(i);
    _departmentSub0List.add(item);
    update();
  }

  DepartmentStage sub0Stage = DepartmentStage.Normal;

  Future<void> getDepartmentSub0Items() async {
    sub0Stage = DepartmentStage.LOADING;
    dynamic response = await DioHelper.get(
      url: '/department/GetDepartmentSub1List?departmentSub0Id=$_departmentSub0Id',
    );
    if (response == null || response == false) {
      sub0Stage = DepartmentStage.ERROR;
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _departmentSub0List.clear();
      for (var element in dynamicList) {
        _departmentSub0List.add(DepSub0Model.fromJson(element));
      }
    }
    sub0Stage = DepartmentStage.DONE;
    update();
  }

  ///
  /// Services List
  ///
  List<OfferItemModel> _servicesList = [];

  List<OfferItemModel> get servicesList => _servicesList;
  String _serviceId = '';

  void setServiceId({required String id}) {
    _serviceId = id;
    getServices();
  }

  Future<void> getServices() async {
    serviceStage = DepartmentStage.LOADING;
    await Get.find<HomeController>().getSlider();
    String requestId = Get.find<OrderController>().requestId;
    dynamic response = await DioHelper.get(
      url: '/Service/GetServiceList?departmentSub1Id=$_serviceId&requestId=$requestId',
    );
    if (response == null || response == false) {
      serviceStage = DepartmentStage.ERROR;
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _servicesList.clear();
      for (var element in dynamicList) {
        _servicesList.add(OfferItemModel.fromJson(element));
      }
    }
    serviceStage = DepartmentStage.DONE;
    update();
  }

  List<OfferItemModel> _searchServicesList = [];

  List<OfferItemModel> get searchServicesList => _searchServicesList;

  void clearServicesList() {
    _searchServicesList.clear();
    update();
  }

  Future<void> getServicesForSearch({required String searchValue}) async {
    serviceStage = DepartmentStage.LOADING;
    update();
    dynamic response = await DioHelper.get(
      url: 'Service/GetServiceList?searchValue=$searchValue',
    );
    if (response == null || response == false) {
      serviceStage = DepartmentStage.ERROR;
      return;
    } else {
      if (response['data'] != null) {
        List<dynamic> dynamicList = response['data'];
        _searchServicesList.clear();
        for (var element in dynamicList) {
          _searchServicesList.add(OfferItemModel.fromJson(element));
        }
      }
    }
    serviceStage = DepartmentStage.DONE;
    update();
  }
}
