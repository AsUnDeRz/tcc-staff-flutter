import 'package:app/model/authen_entity.dart';
import 'package:app/service/api.dart';
import 'package:app/service/jwt_utils.dart';
import 'package:app/service/token_manager.dart';
import 'package:flutter/widgets.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  UserApiProvider apiProvider;
  Status _status = Status.Uninitialized;
  JwtUtils jwtUtils;
  TokenManager tokenManager;
  Status get status => _status;

  UserRepository.instance()
      : apiProvider = UserApiProvider(),
        tokenManager = TokenManager.instance(),
        jwtUtils = JwtUtils();

  Future<AuthenEntity> authen(String username, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      print(_status);

      AuthenEntity _authenEntity = await apiProvider.authen(username, password);
      if (_authenEntity.data != null) {
        _status = Status.Authenticated;
        notifyListeners();
        print(_status);

        print("uid = " + jwtUtils.getUid(_authenEntity.data.accessToken));
        print("exp = ${jwtUtils.getExp(_authenEntity.data.accessToken)}");
        print(
            "isToken expired ${tokenManager.isTokenExpired(jwtUtils.getExp(_authenEntity.data.accessToken))}");
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
