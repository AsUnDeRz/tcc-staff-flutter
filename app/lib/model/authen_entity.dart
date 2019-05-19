import 'package:app/model/base_error_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AuthenEntity {
  AuthenData data;
  BaseError error;

  AuthenEntity(this.data, this.error);

  AuthenEntity.fromJson(Map<String, dynamic> json) {
    try {
      error = json['error'] != null ? new BaseError.fromJson(json['error']) : null;
      data = json['data'] != null ? new AuthenData.fromJson(json['data']) : null;
    } catch (e) {
      print(e);
    }
  }

  AuthenEntity.withError(String error) {
    this.error = BaseError.fromJson({
      "error": {"message": error}
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

@JsonSerializable()
class AuthenData {
  String accessToken;
  String refreshToken;
  String tokenType;

  AuthenData({this.accessToken, this.refreshToken, this.tokenType});

  AuthenData.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}
