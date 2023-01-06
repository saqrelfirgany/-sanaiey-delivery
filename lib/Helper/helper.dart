import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static String userName = '';
  static String userId = '';
  static String clientId = '';
  static String clientName = '';
  static String clientEmail = '';
  static String clientPhone = '';
  static String token = '';
  static String clientSecurityCode = '';
  static bool isLoggedIn = false;

  static String userLoggedKey = 'IsLoggedIn';
  static String usernameKey = 'Username';
  static String userIdKey = 'UserId';
  static String clientIdKey = 'ClientId';
  static String clientNameKey = 'ClientName';
  static String clientEmailKey = 'UserEmail';
  static String clientPhoneKey = 'UserPhone';
  static String clientSecurityCodeKey = 'clientSecurityCode';
  static String userTokenKey = 'UserToken';
  static String mobileToken = '';

  ///
  /// Save User Logged
  ///
  static Future<bool> saveUserLogged(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setBool(userLoggedKey, isLoggedIn);
  }

  ///
  /// Get User Logged
  ///
  static getUserLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(userLoggedKey);
  }

  ///
  /// Save User Id
  ///
  static Future<bool> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(userIdKey, userId);
  }

  ///
  /// Get User Id
  ///
  static getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(userIdKey);
  }

  ///
  /// Save User Token
  ///
  static Future<bool> saveUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(userTokenKey, token);
  }

  ///
  /// Get User Token
  ///
  static getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(userTokenKey);
  }

  ///
  /// Save Client Id
  ///
  static Future<bool> saveClientId(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(clientIdKey, token);
  }

  ///
  /// Get Client Id
  ///
  static getClientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(clientIdKey);
  }

  ///
  /// Save Client Security Code
  ///
  static Future<bool> saveClientSecurityCode(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(clientSecurityCodeKey, code);
  }

  ///
  /// Get Client Security Code
  ///
  static getClientSecurityCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(clientSecurityCodeKey);
  }

  ///
  /// Save Client Name
  ///
  static Future<bool> saveClientName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(clientNameKey, name);
  }

  ///
  /// Get Client Name
  ///
  static getClientName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(clientNameKey);
  }

  ///
  /// Save Username
  ///
  static Future<bool> saveUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(usernameKey, username);
  }

  ///
  /// Get Username
  ///
  static getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(usernameKey);
  }

  ///
  /// Save User Email
  ///
  static Future<bool> saveUserEmail(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(clientEmailKey, username);
  }

  ///
  /// Get User Email
  ///
  static getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(clientEmailKey);
  }

  ///
  /// Save User Phone
  ///
  static Future<bool> saveUserPhone(String userPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(clientPhoneKey, userPhone);
  }

  ///
  /// Get User Phone
  ///
  static getUserPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(clientPhoneKey);
  }
}
