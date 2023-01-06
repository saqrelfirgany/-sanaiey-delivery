import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sanaiey/Helper/dio_helper.dart';
import 'package:sanaiey/Models/MianModels/department_model.dart';
import 'package:sanaiey/Models/MianModels/offer_item_model.dart';
import 'package:sanaiey/Models/MianModels/offers_model.dart';
import 'package:sanaiey/Models/MianModels/slider_model.dart';
import 'package:sanaiey/Models/SubModel/aobut_us_model.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';

import 'cart_controller.dart';

enum HomeStage { Normal, ERROR, LOADING, DONE }

class HomeController extends GetxController {
  HomeStage homeStage = HomeStage.Normal;

  @override
  void onInit() async {
    super.onInit();
    Get.find<CartController>().getCart();
  }

  Future<void> getHomeData() async {
    homeStage = HomeStage.LOADING;
    await Get.find<UserController>().getUser();
    await Get.find<UserController>().getUserAddress();
    await getSlider();
    await getOffers();
    await getDepartments();
    await getAboutUs();
    homeStage = HomeStage.DONE;
    update();
  }

  ///
  /// Home Slider
  ///
  List<Slider> _sliderList = [];

  List<Slider> get sliderList => _sliderList;

  Future<void> getSlider() async {
    dynamic response = await DioHelper.get(url: '/applandingscreen/getbannerlist');
    if (response == null || response == false) {
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _sliderList.clear();
      for (var element in dynamicList) {
        _sliderList.add(Slider.fromJson(element));
      }
    }
    update();
  }

  int sliderIndex = 0;

  void changeSliderIndex({required int index}) {
    sliderIndex = index;
    update();
  }

  ///
  /// Home Offers
  ///
  List<Offers> _offersList = [];

  List<Offers> get offersList => _offersList;

  Future<void> getOffers() async {
    dynamic response = await DioHelper.get(url: '/applandingscreen/getofferlist');
    if (response == null || response == false) {
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _offersList.clear();
      for (var element in dynamicList) {
        _offersList.add(Offers.fromJson(element));
      }
    }
    update();
  }

  ///
  /// Home Offers
  ///
  List<OfferItemModel> _offerItemsList = [];

  List<OfferItemModel> get offerItemsList => _offerItemsList;
  String _offerId = '';

  void setOfferId({required String id}) {
    _offerId = id;
  }

  HomeStage offerStage = HomeStage.Normal;

  Future<void> getOfferItems() async {
    offerStage = HomeStage.LOADING;
    dynamic response = await DioHelper.get(
      url: 'AppLandingScreen/GetOfferServiceList?itemId=$_offerId',
    );
    if (response == null || response == false) {
      offerStage = HomeStage.ERROR;

      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _offerItemsList.clear();
      for (var element in dynamicList) {
        _offerItemsList.add(OfferItemModel.fromJson(element));
      }
    }
    offerStage = HomeStage.DONE;

    update();
  }

  ///
  /// Home Department
  ///
  List<DepartmentModel> _departmentList = [];

  List<DepartmentModel> get departmentList => _departmentList;

  Future<void> getDepartments() async {
    dynamic response = await DioHelper.get(url: '/AppLandingScreen/GetDepartmentList');
    if (response == null || response == false) {
      return;
    } else {
      List<dynamic> dynamicList = response['data'];
      _departmentList.clear();
      for (var element in dynamicList) {
        _departmentList.add(DepartmentModel.fromJson(element));
      }
    }
    update();
  }

  ///
  /// About Us
  ///
  AboutUsModel _aboutUsModel = AboutUsModel();

  AboutUsModel get aboutUsModel => _aboutUsModel;

  Future<void> getAboutUs() async {
    dynamic response = await DioHelper.get(url: 'applandingscreen/getcompanyinfo');
    if (response == null || response == false) {
      return;
    } else {
      _aboutUsModel = AboutUsModel.fromJson(response['data']);
      print('saqr${_aboutUsModel.agreementConditionTerms}');
    }
  }
}
