import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final _darkKey = 'isDark';

  ///
  /// getter for isDarkMode
  ///
  // bool get isDarkMode => _themeMode() ? true : false;

  ///
  /// getter for theme mode
  ///
  ThemeMode get theme => _themeMode() ? ThemeMode.dark : ThemeMode.light;

  ///
  /// Switch Theme and Save it
  ///
  void switchTheme() {
    Get.changeThemeMode(_themeMode() ? ThemeMode.light : ThemeMode.dark);
    _saveTheme(!_themeMode());
  }

  ///
  /// Write App Theme in local storage
  ///
  _saveTheme(bool isDark) => GetStorage().write(_darkKey, isDark);

  ///
  /// Read App Theme from local storage
  ///
  bool _themeMode() => GetStorage().read(_darkKey) ?? false;

  ///
  /// Read App Language from local storage
  ///
  Future<String> get getLang async {
    return await GetStorage().read('lang') ?? 'ar';
  }

  ///
  /// Write App Language in local storage
  ///
  void saveLang(String lang) async {
    await GetStorage().write('lang', lang);
  }
}
