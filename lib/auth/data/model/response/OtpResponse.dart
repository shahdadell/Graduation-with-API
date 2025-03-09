class OtpResponse {
  String? status;

  OtpResponse({this.status});

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
        status: json['status'] as String?,
      );

  String? get message => null;

  Map<String, dynamic> toJson() => {
        'status': status,
      };
}
