import 'package:app/model/authen_entity.dart';
import 'package:app/service/api.dart';
import 'package:app/service/jwt_utils.dart';
import 'package:app/service/share_preference.dart';
import 'package:app/service/token_manager.dart';
import 'package:flutter/widgets.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated, TokenExpired }

class UserRepository extends ChangeNotifier {
  UserApiProvider apiProvider = UserApiProvider();
  Status _status = Status.Uninitialized;
  JwtUtils jwtUtils = JwtUtils();
  TokenManager tokenManager = TokenManager();
  Status get status => _status;

  UserRepository() {
    SharePrefInterface.getInstance().then((share) {
      var token = share.accessToken();
      print(token);
      if (token == "") {
        _status = Status.Unauthenticated;
        return;
      }
      if (tokenManager.isTokenExpired(jwtUtils.getExp(token))) {
        _status = Status.TokenExpired;
      } else {
        _status = Status.Authenticated;
      }
      print(status);
    });
  }

  void logout() {
    SharePrefInterface.getInstance().then((share) {
      share.setTokenType("");
      share.setAccessToken("");
      share.setRefreshToken("");
      _status = Status.Unauthenticated;
      notifyListeners();
    });
  }

  Future<AuthenEntity> authen(String username, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      print(_status);
      AuthenEntity _authenEntity = await apiProvider.authen(username, password);
      if (_authenEntity.data != null) {
        SharePrefInterface.getInstance().then((share) {
          share.setTokenType(_authenEntity.data.tokenType);
          share.setAccessToken(_authenEntity.data.accessToken);
          share.setRefreshToken(_authenEntity.data.refreshToken);
        });
        _status = Status.Authenticated;
        notifyListeners();
        print(_status);
        return _authenEntity;
      } else {
        _status = Status.Unauthenticated;
        notifyListeners();
        print(_status);
        return _authenEntity;
      }
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(_status);
      return null;
    }
  }
}
