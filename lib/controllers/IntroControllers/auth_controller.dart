import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/dio_helper.dart';
import 'package:sanaiey/Helper/helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/Models/IntroModels/user_data_model.dart';
import 'package:sanaiey/Models/IntroModels/user_token_model.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/screens/IntroScreens/LoginScreen/login_screen.dart';
import 'package:sanaiey/screens/IntroScreens/PreLoginScreen/pre_login_screen.dart';
import 'package:sanaiey/screens/IntroScreens/ThanksScreen/thanks_screen.dart';
import 'package:sanaiey/screens/IntroScreens/VerificationLogin/verify_login.dart';
import 'package:sanaiey/screens/IntroScreens/VerificationRegister/verification_register.dart';
import 'package:sanaiey/screens/MainScreens/HomeScreen/home_screen.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/SuccessAlert.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/accont_dialog.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/falier_alert.dart';
import 'package:sanaiey/screens/SharedComponents/getsnack_bars.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lang_controller.dart';

class AuthController extends GetxController {
  ///
  /// Pre Login
  ///
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String phone = '';

  bool loading = false;

  Future<void> preLogin() async {
    if (phoneController.text.isEmpty) {
      showError(title: 'notify', body: 'برجاء ادخال رقم الهاتف بشكل صحيح');
      return;
    }
    FocusScope.of(Get.context!).unfocus();
    loading = true;
    update();
    String url =
        'https://api.sane3ydelivery.com/test/api/Account/IsClientExist/${phoneController.text.trim()}';
    String userLocale = Get.find<LangController>().selectedLang;
    var headers = {
      "Accept": "application/json",
      "lang": userLocale,
      'Authorization': "Bearer ${Helper.token}",
    };
    // http.Response response = await http.get(Uri.parse(url), headers: headers);
    // final dynamic responseData = (jsonDecode(response.body));
    dynamic response = await DioHelper.get(
      url: 'Account/IsClientExist/${phoneController.text.trim()}',
    );
    print(response);
    if (response == null || response == false) {
      loading = false;
      update();
      if (response['statusDescreption'] == 'AlreadyExist') {
        fadNavigate(Get.context!, LoginScreen());
      } else {
        AccountDialog(context: Get.context!, phone: phoneController.text.trim());
      }
      return;
    }else{
      if (response['statusDescreption'].toString() == 'AlreadyExist') {
        fadNavigate(Get.context!, LoginScreen());
      } else {
        AccountDialog(context: Get.context!, phone: phoneController.text.trim());
      }
    }
    // if (response['aleartType'] == 1) {
    //   showToast(body: response['message']);
    // } else if (response['aleartType'] == 2) {
    //   showError(body: response['message']);
    // } else if (response['aleartType'] == 3) {
    //   SuccessAlertDialog(body: response['message'], context: Get.context);
    // } else if (response['aleartType'] == 4) {
    //   FailureAlertDialog(body: response['message'], context: Get.context);
    // }
    loading = false;
    update();
  }

  ///
  /// Login
  ///

  UserTokenModel _userModel = UserTokenModel();

  UserTokenModel get userModel => _userModel;

  UserDataModel _userDataModel = UserDataModel();

  UserDataModel get userDataModel => _userDataModel;

  Future<void> login() async {
    FocusScope.of(Get.context!).unfocus();
    loading = true;
    update();
    dynamic response = await DioHelper.post(url: 'account/loginclient', data: {
      "Password": passwordController.text,
      "Username": phoneController.text.trim(),
    });
    if (response == null || response == false) {
      loading = false;
      update();
      return;
    } else {
      loading = false;
      update();
      if (response['statusDescreption'].toString() == 'Success') {
        loadData(response);
        Navigator.pushAndRemoveUntil(
          Get.context!,
          MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()),
          (route) => false,
        );
      } else if (response['statusDescreption'].toString() == 'InvalidUserOrPassword') {
        // showError(title: 'notify', body: response['message'].toString());
      } else {
        AccountDialog(context: Get.context!, phone: phoneController.text.trim());
      }
    }
    loading = false;
    update();
  }

  Future<void> loadData(response) async {
    _userModel = UserTokenModel.fromJson(response['data']);
    _userDataModel = UserDataModel.fromJson(response['data']['userData']);
    await Helper.saveUserToken(_userModel.token.toString());
    Helper.token = _userModel.token.toString();
    await Helper.saveUserLogged(true);
    Helper.isLoggedIn = true;
    await Helper.saveUsername(_userModel.username.toString());
    Helper.userName = _userModel.username.toString();
    await Helper.saveClientId(_userDataModel.clientId.toString());
    Helper.clientId = _userDataModel.clientId.toString();
    await Helper.saveClientName(_userDataModel.clientName.toString());
    Helper.clientName = _userDataModel.clientName.toString();
    await DioHelper.init();
    await Get.find<UserController>().getData();
  }

  ///
  /// Register
  ///
  bool loadingRegister = false;
  String clientSecurityCode = '';

  Future<void> register() async {
    FocusScope.of(Get.context!).unfocus();

    var name = nameController.text.toString().trim();
    var phone = phoneController.text.toString().trim();
    var email = emailController.text.toString().trim();
    var pass = passwordController.text.toString();
    if (name.isEmpty || name.length < 8 || !name.contains(' ')) {
      showError(title: 'notify', body: 'برجاء ادخال الاسم ثنائي علي الاقل');
      return;
    }
    if (phone.isEmpty || phone.length < 4) {
      showError(title: 'notify', body: 'برجاء ادخال رقم الهاتف بشكل صحيح');
      return;
    }
    if (phone.length > 11) {
      showError(title: 'notify', body: 'الحد الاقصي لرقم الهاتف 11 رقم');
      return;
    }
    if (email.isEmpty || email.length < 5 || !email.contains('@')) {
      showError(title: 'notify', body: 'برجاء ادخال البريد الالكتروني بشكل صحيح');
      return;
    }
    if (pass.isEmpty || pass.length < 5) {
      showError(title: 'notify', body: 'برجاء ادخال رقم سري اكبر من 5 ارقام');
      return;
    }
    loading = true;
    update();
    dynamic response = await DioHelper.post(
      url: 'account/RegisterClient',
      data: {
        'Name': name,
        'Password': pass,
        'Email': email,
        'Phone': phone,
      },
    );
    if (response == null || response == false) {
      loading = false;
      update();
      return;
    } else {
      loading = false;
      update();
      // showError(title: 'notify', body: response['message'].toString());
      if (response['statusDescreption'].toString() == 'AlreadyExist') {
        fadNavigate(Get.context!, LoginScreen());
      }
      if (response['statusDescreption'].toString() == 'ClientRegisterdSuccessfully') {
        _userDataModel = UserDataModel.fromJson(response['data']['client']);
        Helper.saveClientId(_userDataModel.clientId.toString());
        Helper.clientId = _userDataModel.clientId.toString();
        Helper.saveUserPhone(_userDataModel.currentPhone.toString());
        Helper.clientPhone = _userDataModel.currentPhone.toString();
        Helper.saveClientName(_userDataModel.clientName.toString());
        Helper.clientName = _userDataModel.clientName.toString();
        Helper.saveClientSecurityCode(
          response['data']['securityCode'].toString(),
        );
        Helper.clientSecurityCode = response['data']['securityCode'].toString();
        fadNavigate(Get.context!, VerificationRegister(phone: Helper.clientPhone));
      } else {}
    }
    loading = false;
    update();
  }

  String _signature = '';

  generateSignature({
    String otp = '',
    String clientId = '',
    String clientPhone = '',
    String clientSecurityCode = '',
  }) {
    var bytes = utf8.encode(
      '$clientId$clientPhone$otp$clientSecurityCode',
    ); // data being hashed
    var digest = sha256.convert(bytes);
    _signature = '$digest'.toUpperCase();
  }

  ///
  /// Verification Code
  ///
  bool loadingVerification = false;

  Future<void> verificationRegister() async {
    FocusScope.of(Get.context!).unfocus();
    generateSignature(
      otp: otpController.text.toString(),
      clientId: Helper.clientId,
      clientPhone: Helper.clientPhone,
      clientSecurityCode: Helper.clientSecurityCode,
    );
    loading = true;
    update();
    dynamic response = await DioHelper.post(
      url: '/account/ConfirmOTPCode?'
          'clientId=${Helper.clientId}&'
          'phone=${Helper.clientPhone}&'
          'otpCode=${otpController.text}&'
          'signature=$_signature',
    );

    if (response == null || response == false) {
      loading = false;
      update();
      return;
    } else {
      loading = false;
      update();
      // showError(title: 'error', body: response['message'].toString());
      if (response['statusDescreption'].toString() == 'Success') {
        loadData(response);

        Navigator.pushAndRemoveUntil(
          Get.context!,
          MaterialPageRoute(builder: (BuildContext context) => const ThanksScreen()),
          (route) => false,
        );
      } else {
        // showYouDontHaveAnAccountOnThisNumberDialog(
        //   context: context,
        //   phoneNumber: phone,
        // );
      }
    }
    loading = false;
    update();
  }

  ///
  /// Resend Code
  ///
  bool loadingResend = false;

  Future<void> resendCode({required BuildContext context}) async {
    FocusScope.of(context).unfocus();
    var bytes = utf8.encode(
      '${Helper.clientId}${Helper.clientPhone}${Helper.clientSecurityCode}',
    ); // data being hashed
    var digest = sha256.convert(bytes);
    print(digest);
    loadingResend = true;
    update();
    print('clientId=${Helper.clientId}&');
    print('phone=${phoneController.text}&');
    print('signature=$digest');
    dynamic response = await DioHelper.post(
      url: '/account/resendotpcode?'
          'clientId=${Helper.clientId}&'
          'phone=${phoneController.text}&'
          'signature=$digest',
    );

    if (response == null || response == false) {
      loadingResend = false;
      update();
      return;
    } else {
      loadingResend = false;
      update();
      // showError(title: 'notify', body: response['message'].toString());
    }
    loadingResend = false;
    update();
  }

  ///
  /// Register With OTP
  ///

  Future<void> loginWithOTP({required BuildContext context}) async {
    FocusScope.of(context).unfocus();
    loadingVerification = true;
    update();
    dynamic response = await DioHelper.get(
      url: '/account/RequestOTPForLogin/${phoneController.text.trim()}',
    );
    if (response == null || response == false) {
      loadingVerification = false;
      update();
      return;
    } else {
      loadingVerification = false;
      update();
      // showError(title: 'notify', body: response['message'].toString());
      if (response['statusDescreption'].toString() == 'Success') {
        fadNavigate(context, VerificationLogin());
      }
    }
    loadingVerification = false;
    update();
  }

  ///
  /// Verification Code
  ///
  bool verificationLogin = false;

  Future<void> verifyLogin({required BuildContext context}) async {
    FocusScope.of(context).unfocus();

    loadingVerification = true;
    update();
    print(phoneController.text.toString().trim());
    dynamic response = await DioHelper.post(url: '/account/LoginClientWithOtp', data: {
      'Phone': phoneController.text.toString().trim(),
      'OtpCode': otpController.text.toString(),
    });

    if (response == null || response == false) {
      loadingVerification = false;
      update();
      return;
    } else {
      loadingVerification = false;
      update();
      // showError(title: 'notify', body: response['message'].toString());
      if (response['statusDescreption'].toString() == 'Success') {
        loadData(response);
        await DioHelper.init();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen(),
          ),
          (route) => false,
        );
      } else {
        // showYouDontHaveAnAccountOnThisNumberDialog(
        //   context: context,
        //   phoneNumber: phone,
        // );
      }
    }
    loadingVerification = false;
    update();
  }

  void logout() async {
    Get.find<SharedPreferences>().clear();
    Helper.token = '';
    await Helper.saveUserToken('');
    Helper.isLoggedIn = false;
    await Helper.saveUserLogged(false);
    Navigator.pushAndRemoveUntil(
      Get.context!,
      MaterialPageRoute(
        builder: (BuildContext context) => const PreLoginScreen(),
      ),
      (route) => false,
    );
    // Get.offAll(() => LoginScreen());
  }
}
