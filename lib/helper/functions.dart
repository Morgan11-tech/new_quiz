import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String UserLoggedInKey = "USERLOGGEDINKEY";
  static saveUserLoginDetails({required bool isloggedIn}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(UserLoggedInKey, isloggedIn);
  }

  static Future<bool?> getUserLoginDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(UserLoggedInKey);
  }
}
