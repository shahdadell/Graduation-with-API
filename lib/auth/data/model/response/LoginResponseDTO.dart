import 'package:graduation_project/auth/data/model/response/RegisterResponse.dart';

/// status : "success"
/// message : "none"

class LoginResponseDTO {
  LoginResponseDTO({
    this.status,
    this.message,
  });

  LoginResponseDTO.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }
  String? status;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }

  AuthResultEntity toAuthResultEntity() {
    return AuthResultEntity();
  }
}
