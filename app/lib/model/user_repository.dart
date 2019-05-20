import 'package:app/model/authen_entity.dart';
import 'package:app/service/api.dart';
import 'package:app/service/jwt_utils.dart';
import 'package:app/service/share_preference.dart';
import 'package:app/service/token_manager.dart';
import 'package:flutter/widgets.dart';

import '../locator.dart';

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
      if (token == "") {
        _status = Status.Uninitialized;
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
        print("uid = " + jwtUtils.getUid(_authenEntity.data.accessToken));
        print("exp = ${jwtUtils.getExp(_authenEntity.data.accessToken)}");
        print(
            "isToken expired ${tokenManager.isTokenExpired(jwtUtils.getExp(_authenEntity.data.accessToken))}");
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
