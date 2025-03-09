class OtpErrorr {
  String? status;
  String? message;

  OtpErrorr({this.status, this.message});

  factory OtpErrorr.fromJson(Map<String, dynamic> json) => OtpErrorr(
        status: json['status'] as String?,
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}
