import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:sanaiey/Helper/dio_helper.dart';
import 'package:sanaiey/utils/local_storage/local_storage.dart';

class LangController extends GetxController {
  String appLang = 'ar';
  String _selectedLang = 'ar';

  @override
  void onInit() async {
    LocalStorage localStorage = LocalStorage();
    appLang = await localStorage.getLang;
    _selectedLang = appLang;
    super.onInit();
  }

  final List<String> _items = ['en', 'ar'];

  List<String> get items => _items;

  String get selectedLang => _selectedLang;

  Future<void> changeLang(item) async {
    if (item == _selectedLang) return;
    _selectedLang = item;
    Get.updateLocale(Locale(_selectedLang));
    LocalStorage _localStorage = LocalStorage();
    _localStorage.saveLang(_selectedLang);
    // Get.find<ApiClient>().updateHeaderLang(lang: _selectedLang);
    await DioHelper.init();
    update();
  }
}
