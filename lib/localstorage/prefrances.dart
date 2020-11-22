
import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferences {
  static bool isLogin = false;
  static String email;
  static String name ;
  static String phoneNumber ;
  static String profileUrl ;
  static String userId ;
  static bool emailVarfied = false;
  static bool phoneNumberVarified = false;

  static setLogin(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_login', value);
  }

  static Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('is_login') ?? false;
    return isLogin;
  }

  static setEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', value);
  }

  static Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email') ?? null;
    return email;
  }

  static setName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', value);
  }

  static Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? null;
    return name;
  }

  static setProfileUrl(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profile_url', value);
  }

  static Future<String> getProfileUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    profileUrl = prefs.getString('profile_url') ?? null;
    return profileUrl;
  }

  static setUserId(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', value);
  }

  static Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id') ?? null;
    return userId;
  }

  static setPhoneNumber(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone_number', value);
  }

  static Future<String> getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumber = prefs.getString('phone_number')?? null;
    return phoneNumber;
  }

  static setEmailVarified(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('email_varified', value);
  }

  static Future<bool> isEmailVarified() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emailVarfied = prefs.getBool('email_varified')?? null;
    return emailVarfied;
  }


  static setPhoneNumberVerified(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('phone_number_varified', value);
  }

  static Future<bool> idPhoneNumberNumberVerified() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumberVarified = prefs.getBool('phone_number_varified')?? null;
    return phoneNumberVarified;
  }



  static clearPreferances() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
