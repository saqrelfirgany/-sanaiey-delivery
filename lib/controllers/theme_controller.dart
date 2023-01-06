import 'package:get/get.dart';

import '../utils/local_storage/local_storage.dart';

class ThemeController extends GetxController {
  bool _dark = Get.isDarkMode;

  get dark => _dark ? 'dark' : 'light';

  void changeTheme(value) {
    _dark = !_dark;
    LocalStorage().switchTheme();
    update();
  }
}
