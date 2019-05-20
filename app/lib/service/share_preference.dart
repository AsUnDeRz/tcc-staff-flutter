import 'package:shared_preferences/shared_preferences.dart';

class SharePrefInterface {
  static const ACCESS_TOKEN = "access_token";
  static const REFRESH_TOKEN = "refresh_token";
  static const TYPE_TOKEN = "type_token";
  static SharePrefInterface _instance;
  static SharedPreferences sharedPreferences;
  static Future<SharePrefInterface> getInstance() async {
    if (_instance == null) {
      _instance = SharePrefInterface();
    }
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  String accessToken() {
    return sharedPreferences.getString(ACCESS_TOKEN) ?? "";
  }

  setAccessToken(String token) {
    sharedPreferences.setString(ACCESS_TOKEN, token ?? "");
  }

  String refreshToken() {
    return sharedPreferences.getString(REFRESH_TOKEN) ?? "";
  }

  setRefreshToken(String token) {
    sharedPreferences.setString(REFRESH_TOKEN, token ?? "");
  }

  String tokenType() {
    return sharedPreferences.getString(TYPE_TOKEN) ?? "";
  }

  setTokenType(String token) {
    sharedPreferences.setString(TYPE_TOKEN, token ?? "");
  }
}
