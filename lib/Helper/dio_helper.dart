import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaiey/controllers/lang_controller.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/SuccessAlert.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/falier_alert.dart';
import 'package:sanaiey/screens/SharedComponents/getsnack_bars.dart';

import 'helper.dart';

class DioHelper {
  static Dio? dio;

  /// Auto show errors
  static bool isAutoShowErrors = true;

  /// Initialize dio
  static Future init() async {
    /// Get user language code from storage
    String userLocale = Get.find<LangController>().selectedLang;

    /// Get user auth token
    // Helper.token = await Helper.getUserToken();

    /// Set headers
    var headers = {
      "Accept": "application/json",
      "lang": userLocale,
      'Authorization': "Bearer ${Helper.token}",
    };

    /// Set dio
    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.sane3ydelivery.com/test/api/",
        followRedirects: true,
        receiveDataWhenStatusError: true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: headers,
        connectTimeout: 20 * 1000,
        // 60 seconds
        receiveTimeout: 20 * 1000,
        // 60 seconds
        validateStatus: (status) {
          return status! < 800;
        },
      ),
    );
  }

  ///
  /// GET
  ///
  static Future get({required String url}) async {
    ///
    /// Send request
    ///
    try {
      var response = await dio!.get(url);
      print(response);
      if (response.statusCode == 200) {
        dynamic dynamicResponse = await jsonDecode(response.toString());
        if (dynamicResponse['aleartType'] == 1) {
          showToast(body: dynamicResponse['message']);
        } else if (dynamicResponse['aleartType'] == 2) {
          showError(body: dynamicResponse['message']);
        } else if (dynamicResponse['aleartType'] == 3) {
          SuccessAlertDialog(
            body: dynamicResponse['message'],
            context: Get.context,
            press: () {
              Navigator.pop(Get.context!);
            },
          );
        } else if (dynamicResponse['aleartType'] == 4) {
          FailureAlertDialog(body: dynamicResponse['message'], context: Get.context);
        }
        if (dynamicResponse['statusCode'] == 0) {

          return dynamicResponse;
        }
        return dynamicResponse;
      } else {
        dynamic res = await jsonDecode(response.toString());
        showError(title: 'error', body: res['message'].toString());
        return false;
      }
    } on DioError catch (e) {
      if (e.error is SocketException || e.type == DioErrorType.connectTimeout) {
        showError(title: 'error', body: 'برجاء التحقق من اتصال الانترنت');
        return false;
      }
    } catch (e) {
      // showError(title: 'error', body: 'حدث خطاء برجاء المحاول مره اخري');
      return false;
    }
  }

  ///
  /// POST
  ///
  static Future post({url, dynamic data}) async {
    ///
    /// Send request
    ///
    print('data:$data');
    try {
      final response = await dio!.post(url, data: data);
      print('response:$response');
      print('response statusCode:${response.statusCode}');
      if (response.statusCode == 200) {
        dynamic dynamicResponse = await jsonDecode(response.toString());
        if (dynamicResponse['aleartType'] == 1) {
          showToast(body: dynamicResponse['message']);
        } else if (dynamicResponse['aleartType'] == 2) {
          showError(body: dynamicResponse['message']);
        } else if (dynamicResponse['aleartType'] == 3) {
          SuccessAlertDialog(
            body: dynamicResponse['message'],
            context: Get.context,
            press: () {
              Navigator.pop(Get.context!);
            },
          );
        } else if (dynamicResponse['aleartType'] == 4) {
          FailureAlertDialog(body: dynamicResponse['message'], context: Get.context);
        }
        if (dynamicResponse['statusCode'] == 0) {
          // showError(body: dynamicResponse['message']);
          return false;
        }
        return dynamicResponse;
      } else {
        dynamic res = await jsonDecode(response.toString());
        showError(title: 'error', body: res['message'].toString());
        return false;
      }
    } on DioError catch (e) {
      if (e.error is SocketException || e.type == DioErrorType.connectTimeout) {
        showError(title: 'error', body: 'برجاء التحقق من اتصال الانترنت');
        return false;
      }
    } catch (e) {
      // showError(title: 'error', body: 'حدث خطاء برجاء المحاول مره اخري');
      return false;
    }
  }
}
