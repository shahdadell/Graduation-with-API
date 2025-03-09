class LoginResponse {
  String? status;
  String? message;

  LoginResponse({this.status, this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json['status'] as String?,
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}
