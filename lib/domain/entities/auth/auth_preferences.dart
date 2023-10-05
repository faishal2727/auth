import 'package:shared_preferences/shared_preferences.dart';

class AuthPreferences {
  final String auth = "auth";
  final String token = "token";

  Future<bool> isLogin() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(auth) ?? false;
  }

  Future<bool> setLogin() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setBool(auth, true);
  }

  Future<bool> isLogout() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setBool(auth, false);
  }

  Future<String> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(token) ?? "";
  }

  Future<bool> setToken(String touken) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(token, touken);
  }
}
