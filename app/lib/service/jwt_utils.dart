import 'dart:convert';

import 'package:jaguar_jwt/jaguar_jwt.dart';

class JwtUtils {
  JwtUtils();

  dynamic decodeToken(String token) {
    try {
      final parts = token.split('.');
      final payload = parts[1];
      final model = json.decode(B64urlEncRfc7515.decodeUtf8(payload));
      return model;
    } on FormatException {
      print("That string didn't look like Json.");
      return null;
    } on NoSuchMethodError {
      print('That string was null!');
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  String getUid(String accessToken) {
    dynamic model = decodeToken(accessToken);
    if (model != null) {
      return "${model['uid']}";
    } else {
      return null;
    }
  }

  int getExp(String accessToken) {
    dynamic model = decodeToken(accessToken);
    if (model != null) {
      return model['exp'];
    } else {
      return null;
    }
  }
}
