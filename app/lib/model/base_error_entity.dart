import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BaseErrorEntity {
  BaseError error;

  BaseErrorEntity({this.error});

  factory BaseErrorEntity.fromJson(Map<String, dynamic> json) => new BaseErrorEntity(
      error: json['error'] != null ? new BaseError.fromJson(json['error']) : null);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data['error'] = this.error.toJson();
    }
    return data;
  }
}

@JsonSerializable()
class BaseError {
  int code;
  String type;
  String message;

  BaseError({this.code, this.type, this.message});

  BaseError.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    type = json['type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['type'] = this.type;
    data['message'] = this.message;
    return data;
  }
}
