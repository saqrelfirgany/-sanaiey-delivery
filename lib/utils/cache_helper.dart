//import 'package:flutter/cupertino.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//class CacheHelper {
//  static   SharedPreferences ?   sharedPreferences;
//  static init()async{
//     sharedPreferences = await SharedPreferences.getInstance();
//  }
// static Future<bool> putStringData({
//    @required String ?  key,
//    @required dynamic value,
//  })async {
//    return await  sharedPreferences!.setString(key!, value);
//  }
//  static String getStringData({@required String  ? key}) {
//     return sharedPreferences.getString(key);
//  }
//  static Future<bool>  clearData({@required String key}) async{
//     return await sharedPreferences.remove(key);
//  }
//
//}