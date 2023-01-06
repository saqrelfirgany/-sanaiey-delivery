import 'package:get/get.dart';
import 'package:sanaiey/Helper/dio_helper.dart';
import 'package:sanaiey/Models/IntroModels/city_model.dart';
import 'package:sanaiey/Models/IntroModels/governorate_model.dart';
import 'package:sanaiey/Models/IntroModels/region_model.dart';
import 'package:sanaiey/screens/MainScreens/HomeScreen/home_screen.dart';

enum AddressStage { Normal, ERROR, LOADING, DONE }

class SelectAddressController extends GetxController {
  AddressStage addressStage = AddressStage.Normal;

  Future<void> getAddressData() async {
    addressStage = AddressStage.LOADING;
    await getGovernorate();
    await getCity();
    await getRegion();
    addressStage = AddressStage.DONE;
    update();
  }

  ///
  /// Location
  ///
  String governorateId = '';
  String governorateName = '';

  List<Governorate> _governorateList = [];

  List<Governorate> get governorateList => _governorateList;

  Future<void> changeGovernorateId({required String? item}) async {
    if (item == null) return;
    for (var element in _governorateList) {
      if (item == element.governorateName) {
        governorateId = element.governorateId.toString();
        governorateName = element.governorateName.toString();
      }
    }
    await getCity();
  }

  Future<void> changeGovernorate({required Governorate? item}) async {
    if (item == null) return;
    _governorateList.forEach((element) {
      if (item.governorateId == element.governorateId) {
        governorateId = '${element.governorateId}';
        governorateName = '${element.governorateName}';
      }
    });
    await getCity();
  }

  bool loadingData = false;

  Future<void> getGovernorate() async {
    loadingData = true;
    update();
    dynamic response = await DioHelper.get(url: 'Address/GetGovernorateList/1');
    if (response == null || response == false) {
      loadingData = false;
      update();
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _governorateList.clear();
      for (var element in dynamicList) {
        _governorateList.add(Governorate.fromJson(element));
      }
      governorateName = _governorateList[0].governorateName.toString();
      governorateId = _governorateList[0].governorateId.toString();
    }
    loadingData = false;
    update();
  }

  ///
  /// Area
  ///
  String cityId = '';
  String cityName = '';

  List<City> _cityList = [];

  List<City> get cityList => _cityList;

  void changeCity({required String? item}) {
    if (item == null) return;
    for (var element in _cityList) {
      if (item == element.cityName) {
        cityId = element.cityId.toString();
        cityName = element.cityName.toString();
      }
    }
    getRegion();
  }

  Future<void> changeCityModel({required City? item}) async {
    if (item == null) return;
    _cityList.forEach((element) {
      if (item.cityId == element.cityId) {
        cityId = '${element.cityId}';
        cityName = '${element.cityName}';
      }
    });
    await getRegion();
  }

  bool loadingCity = false;

  Future<void> getCity() async {
    loadingCity = true;
    loadingRegion = true;
    update();
    dynamic response = await DioHelper.get(url: 'Address/GetCityList/$governorateId');
    if (response == null || response == false) {
      loadingCity = false;
      loadingRegion = false;
      update();
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _cityList.clear();
      for (var element in dynamicList) {
        _cityList.add(City.fromJson(element));
      }
      cityId = _cityList[0].cityId.toString();
      cityName = _cityList[0].cityName.toString();
    await  getRegion();
    }
    loadingCity = false;
    loadingRegion = false;
    update();
  }

  ///
  /// Region
  ///
  String _regionId = '';
  String regionName = '';

  String get regionId => _regionId;

  List<RegionModel> _regionList = [];

  List<RegionModel> get regionList => _regionList;

  void changeRegion({required String? item}) {
    if (item == null) return;
    for (var element in _regionList) {
      if (item == element.regionName) {
        _regionId = element.regionId.toString();
        regionName = element.regionName.toString();
      }
    }
    print(_regionId);
  }

  Future<void> changeRegionModel({required RegionModel? item})async {
    if (item == null) return;
    _regionList.forEach((element) {
      if (item.regionId == element.regionId) {
        _regionId = '${element.regionId}';
        regionName = '${element.regionName}';
      }
    });
    print('_regionId$_regionId');
  }
  bool loadingRegion = false;

  Future<void> getRegion() async {
    loadingRegion = true;
    update();
    dynamic response = await DioHelper.get(url: '/Address/GetRegionList/$cityId');
    if (response == null || response == false) {
      loadingRegion = false;
      update();
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _regionList.clear();
      for (var element in dynamicList) {
        _regionList.add(RegionModel.fromJson(element));
      }
      _regionId = _regionList[0].regionId.toString();
      regionName = _regionList[0].regionName.toString();
    }
    loadingRegion = false;
    update();
  }

  bool updating = false;

  Future<bool> updateBranchIdByRegionId() async {
    updating = true;
    update();
    dynamic response = await DioHelper.post(url: '/Client/UpdateBranchByRegion?regionId=$_regionId');
    if (response == null || response == false) {
      updating = false;
      update();
      return false;
    } else {
      updating = false;
      update();
      Get.offAll(() => HomeScreen());
      return true;
    }
    updating = false;
    update();
  }

  ///
  /// Area
  ///
  Future<void> done() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
