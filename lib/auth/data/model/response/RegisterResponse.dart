/// status : "success"
/// message : "User registered successfully. Please check your email to complete the registration."

class AuthResultEntity {
  AuthResultEntity({
    String? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  AuthResultEntity.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  String? _status;
  String? _message;
  AuthResultEntity copyWith({
    String? status,
    String? message,
  }) =>
      AuthResultEntity(
        status: status ?? _status,
        message: message ?? _message,
      );
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}
