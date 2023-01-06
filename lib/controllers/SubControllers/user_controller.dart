import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/dio_helper.dart';
import 'package:sanaiey/Helper/helper.dart';
import 'package:sanaiey/Models/MianModels/settings_model.dart';
import 'package:sanaiey/Models/SubModel/address_model.dart';
import 'package:sanaiey/Models/SubModel/phone_model.dart';
import 'package:sanaiey/Models/SubModel/user_model.dart';
import 'package:sanaiey/controllers/IntroControllers/select_address_controller.dart';
import 'package:sanaiey/controllers/MainControllers/cart_controller.dart';
import 'package:sanaiey/controllers/MainControllers/home_controller.dart';
import 'package:sanaiey/screens/IntroScreens/SelectAddress/select_address.dart';
import 'package:sanaiey/screens/SharedComponents/getsnack_bars.dart';

import '../../Models/SubModel/points_model.dart';

enum UserStage { Normal, ERROR, LOADING, DONE }

class UserController extends GetxController {
  UserStage userStage = UserStage.Normal;

  Future<void> getData() async {
    userStage = UserStage.LOADING;
    await getUser();
    await getUserAddress();
    await getUserPhone();
    await Get.find<SelectAddressController>().getAddressData();
    await getSettings();
    userStage = UserStage.DONE;
    update();
  }

  ///
  /// Points Model
  ///
  List<PointsModel> _pointsList = [];

  List<PointsModel> get pointsList => _pointsList;
  UserStage pointsStage = UserStage.LOADING;

  Future<void> getUserPoints() async {
    pointsStage = UserStage.LOADING;
    dynamic response = await DioHelper.get(url: 'Client/Getpointlist');
    if (response == null || response == false) {
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _pointsList.clear();
      for (var element in dynamicList) {
        _pointsList.add(PointsModel.fromJson(element));
      }
    }
    print('saqr${_pointsList.length}');
    pointsStage = UserStage.DONE;
    update();
  }

  UserStage AddressAndPhone = UserStage.LOADING;

  Future<void> getUserAddressAndPhone() async {
    AddressAndPhone = UserStage.LOADING;

    await getUserAddress();
    await getUserPhone();
    AddressAndPhone = UserStage.DONE;
    update();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  UserModel userInfo = UserModel();

  Future<void> getUser() async {
    dynamic response = await DioHelper.get(url: '/Client/Get/${Helper.clientId}');
    if (response == null || response == false) {
      return;
    } else {
      userInfo = UserModel.fromJson(response['data']);
      nameController.text = '${userInfo.clientName}';
      emailController.text = '${userInfo.clientEmail}';
      Helper.clientName = '${userInfo.clientName}';
      Helper.clientEmail = '${userInfo.clientEmail}';
      Helper.saveClientName('${userInfo.clientName}');
      Helper.saveUserEmail('${userInfo.clientEmail}');
      update();
      if (userInfo.branchId == null) {
        Get.offAll(() => SelectAddressScreen());
      }
    }
  }

  bool loading = false;

  Future<void> updateClientName() async {
    var name = nameController.text.toString().trim();
    if (name.isEmpty || name.length < 8 || !name.contains(' ')) {
      showError(title: 'notify', body: 'برجاء ادخال الاسم ثنائي علي الاقل');
      return;
    }
    loading = true;
    update();
    dynamic response = await DioHelper.post(
      url: '/Client/UpdateName?name=${nameController.text}',
      // data: {"clientId": Helper.clientId, "clientName": name},
    );
    if (response == null || response == false) {
      loading = false;
      update();
      return;
    } else {
      getUser();
      loading = false;
      update();
      Navigator.pop(Get.context!);
      // showError(title: 'notify', body: response['message'].toString());
      update();
    }
  }

  Future<void> updateClientEmail() async {
    var email = emailController.text.toString().trim();
    if (email.isEmpty || email.length < 5 || !email.contains('@')) {
      showError(title: 'notify', body: 'برجاء ادخال البريد الالكتروني بشكل صحيح');
      return;
    }
    loading = true;
    update();
    dynamic response = await DioHelper.post(
      url: '/Client/UpdateEmail?email=${emailController.text}',
      // data: {"clientId": Helper.clientId, "clientEmail": email},
    );
    if (response == null || response == false) {
      loading = false;
      update();
      return;
    } else {
      getUser();
      loading = false;
      update();
      Navigator.pop(Get.context!);
      // showError(title: 'notify', body: response['message'].toString());
      update();
    }
  }

  ///
  /// User Address
  ///
  AddressModel _address = AddressModel();

  AddressModel get address => _address;

  void setAddress({required AddressModel address}) {
    _address = address;
  }

  List<AddressModel> _addressList = [];

  List<AddressModel> get addressList => _addressList;

  Future<void> getUserAddress() async {
    dynamic response = await DioHelper.get(url: '/Client/GetAddressList');
    if (response == null || response == false) {
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _addressList.clear();
      for (var element in dynamicList) {
        _addressList.add(AddressModel.fromJson(element));
      }
      if (_addressList.isNotEmpty) {
        for (var item in _addressList) {
          if (item.isDefault) {
            addressModel = item;
          }
        }
      }
    }
    update();
  }

  AddressModel addressModel = AddressModel();
  AddressModel addressModelNew = AddressModel();
  bool changeAddressFlag = false;

  void changeAddress({changeAddress}) {
    addressModelNew = changeAddress;
  }

  Future<void> updateDefaultAddress({bool popFlag = true}) async {
    if (addressModelNew.addressId == null) {
      showError(title: 'title', body: 'برجاء تحديد عنوان');
      return;
    }
    loading = true;
    update();
    dynamic response = await DioHelper.post(
      url: '/Client/SetDefaultAddress?addressId=${addressModelNew.addressId}',
    );

    if (response == null || response == false) {
      loading = false;
      update();
      return;
    } else {
      await Get.find<HomeController>().getHomeData();
      await Get.find<CartController>().getCartData();
      loading = false;
      update();
      if (popFlag) {
        Navigator.pop(Get.context!);
      }
    }
  }

  Future<void> deleteAddress({required String id}) async {
    dynamic response = await DioHelper.post(
      url: 'Client/DeleteAddress/$id',
    );

    if (response == null || response == false) {
      update();
      return;
    } else {
      await getUserAddress();
      update();
    }
  }

  ///
  /// Get Settings
  ///
  List<SettingsModel> _settingsList = [];

  List<SettingsModel> get settingsList => _settingsList;
  String changeCartAddressMessage = '';
  String serviceGuaranteeImage = '';

  Future<void> getSettings() async {
    dynamic response = await DioHelper.get(url: '/Setting/GetAppSettingList');
    if (response == null || response == false) {
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _settingsList.clear();
      for (var element in dynamicList) {
        _settingsList.add(SettingsModel.fromJson(element));
        _settingsList.forEach((element) {
          if (element.settingKey == 'ChangeCartAddressMessage') {
            changeCartAddressMessage = element.settingValue;
          }
          if (element.settingKey == 'ServiceGuaranteeImage') {
            serviceGuaranteeImage = element.settingValue;
          }
        });
      }
    }
    update();
  }

  bool validate() {
    var addressStreet = addressStreetController.text.toString().trim();
    var addressBlockNum = addressBlockNumController.text.toString().trim();
    var addressFlatNum = addressFlatNumController.text.toString().trim();
    var addressDes = addressDesController.text.toString().trim();
    if (addressStreet.isEmpty) {
      showError(title: 'notify', body: 'برجاء ادخال اسم الشارع');
      return false;
    }
    if (addressBlockNum.isEmpty) {
      showError(title: 'notify', body: 'برجاء ادخال رقم المبني');
      return false;
    }
    if (addressFlatNum.isEmpty) {
      showError(title: 'notify', body: 'برجاء ادخال الدور');
      return false;
    }
    if (addressDes.isEmpty) {
      showError(title: 'notify', body: 'برجاء ادخال الوصف');
      return false;
    }
    return true;
  }

  ///
  TextEditingController addressStreetController = TextEditingController();
  TextEditingController addressBlockNumController = TextEditingController();
  TextEditingController addressFlatNumController = TextEditingController();
  TextEditingController addressDesController = TextEditingController();

  Future<void> addAddress({lat, lng, mapDescription}) async {
    if (!validate()) return;
    var addressStreet = addressStreetController.text.toString().trim();
    var addressBlockNum = addressBlockNumController.text.toString().trim();
    var addressFlatNum = addressFlatNumController.text.toString().trim();
    var addressDes = addressDesController.text.toString().trim();
    var userAddressController = Get.find<SelectAddressController>();
    loading = true;
    update();
    dynamic response = await DioHelper.post(
      url: '/Client/AddAddress',
      data: {
        "clientId": Helper.clientId,
        "governorateId": userAddressController.governorateId,
        "cityId": userAddressController.cityId,
        "regionId": userAddressController.regionId,
        "addressGov": userAddressController.governorateName,
        "addressCity": userAddressController.cityName,
        "addressRegion": userAddressController.regionName,
        "addressStreet": addressStreet,
        "addressBlockNum": addressBlockNum,
        "addressFlatNum": addressFlatNum,
        "addressDes": addressDes,
        "location": mapDescription,
        "latitude": lat,
        "longitude": lng,
      },
    );
    if (response == null || response == false) {
      loading = false;
      update();
      return;
    } else {
      getUserAddress();
      loading = false;
      update();
      Navigator.pop(Get.context!);
      // showError(title: 'notify', body: response['message'].toString());
      update();
    }
  }

  Future<void> updateAddress({lat, lng, mapDescription, addressId, isDefault}) async {
    print('saqr latitude $lat');
    print('saqr longitude $lng');
    print('saqr mapDescription $mapDescription');
    if (!validate()) return;
    var addressStreet = addressStreetController.text.toString().trim();
    var addressBlockNum = addressBlockNumController.text.toString().trim();
    var addressFlatNum = addressFlatNumController.text.toString().trim();
    var addressDes = addressDesController.text.toString().trim();
    var userAddressController = Get.find<SelectAddressController>();
    loading = true;
    update();
    dynamic response = await DioHelper.post(
      url: '/Client/UpdateAddress',
      data: {
        "addressId": addressId,
        "clientId": Helper.clientId,
        "governorateId": userAddressController.governorateId,
        "cityId": userAddressController.cityId,
        "regionId": userAddressController.regionId,
        "addressGov": userAddressController.governorateName,
        "addressCity": userAddressController.cityName,
        "addressRegion": userAddressController.regionName,
        "addressStreet": addressStreet,
        "addressBlockNum": addressBlockNum,
        "addressFlatNum": addressFlatNum,
        "addressDes": addressDes,
        "location": mapDescription,
        "latitude": lat,
        "longitude": lng,
        "isDefault": isDefault,
      },
    );
    if (response == null || response == false) {
      loading = false;
      update();
      return;
    } else {
      getUserAddress();
      loading = false;
      update();
      Navigator.pop(Get.context!);
      // showError(title: 'notify', body: response['message'].toString());
      update();
    }
  }

  ///
  /// User Phone
  ///
  List<PhoneModel> _phoneList = [];

  List<PhoneModel> get phoneList => _phoneList;

  Future<void> getUserPhone() async {
    dynamic response = await DioHelper.get(url: '/Client/GetPhoneList');
    if (response == null || response == false) {
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _phoneList.clear();
      for (var element in dynamicList) {
        _phoneList.add(PhoneModel.fromJson(element));
      }
    }
    update();
  }

  Future<void> addPhone() async {
    var phone = phoneController.text.trim().toString();
    if (phone.isEmpty) {
      showError(title: 'notify', body: 'برجاء ادخال رقم الهاتف');
      return;
    }
    loading = true;
    update();
    dynamic response = await DioHelper.post(
      url: '/Client/AddPhone',
      data: {
        "clientId": Helper.clientId,
        "clientPhone": phone,
      },
    );

    if (response == null || response == false) {
      loading = false;
      update();
      return;
    } else {
      getUserPhone();
      loading = false;
      update();
      Navigator.pop(Get.context!);
      // showError(title: 'notify', body: response['message'].toString());
      update();
    }
  }

  PhoneModel _phone = PhoneModel();

  PhoneModel get phone => _phone;

  void setPhone({required PhoneModel phone}) {
    _phone = phone;
    phoneController.text = _phone.clientPhone ?? '';
  }

  Future<void> updatePhone() async {
    var phone = phoneController.text.trim().toString();
    if (phone.isEmpty) {
      showError(title: 'notify', body: 'برجاء ادخال رقم الهاتف');
      return;
    }
    print('saqr${phoneController.text}');
    loading = true;
    update();

    dynamic response = await DioHelper.post(
      url: 'Client/UpdatePhone',
      data: {
        "clientPhoneId": _phone.clientPhoneId,
        "clientId": Helper.clientId,
        "clientPhone": '${phoneController.text}',
        "pwdUsr": _phone.pwdUsr,
        "code": _phone.code,
        "active": _phone.active,
        "isDefault": _phone.isDefault,
        "client": _phone.client,
        "requestT": _phone.requestT,
      },
    );

    if (response == null || response == false) {
      loading = false;
      update();
      return;
    } else {
      getUserPhone();
      loading = false;
      update();
      Navigator.pop(Get.context!);
      // showError(title: 'notify', body: response['message'].toString());
      update();
    }
  }

  Future<void> deletePhone({required String id}) async {
    loading = true;
    update();
    dynamic response = await DioHelper.post(
      url: 'Client/DeletePhone/$id',
    );

    if (response == null || response == false) {
      loading = false;
      update();
      return;
    } else {
      getUserPhone();
      loading = false;
      update();
    }
  }

}
