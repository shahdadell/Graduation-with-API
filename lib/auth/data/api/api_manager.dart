import 'dart:convert';
import 'package:graduation_project/auth/data/model/request/LoginRequest.dart';
import 'package:graduation_project/auth/data/model/request/OtpForgetPasswordRequest.dart';
import 'package:graduation_project/auth/data/model/request/OtpRequest.dart';
import 'package:http/http.dart' as http;
import '../model/request/CheckEmailRequest.dart';
import '../model/request/RegisterRequest.dart';
import '../model/response/RegisterResponse.dart';
import 'api_constance.dart';

class ApiManager {
  ApiManager._();
  static ApiManager? _instance;
  static ApiManager getInstance() {
    _instance ??= ApiManager._();
    return _instance!;
  }

  Future<AuthResultEntity> register(
      String username, String password, String email, String phone) async {
    //https://abdulrahmanantar.com/outbye/auth/signup.php
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.registerApi);
    var requestBody = RegisterRequest(
      username: username,
      email: email,
      password: password,
      phone: phone,
    );
    var response = await http.post(url, body: requestBody.toJson());
    return AuthResultEntity.fromJson(jsonDecode(response.body));
  }



  Future<AuthResultEntity> login(
    String password,
    String email,
  ) async {
    //https://abdulrahmanantar.com/outbye/auth/login.php
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.LoginApi);
    var requestBody = LoginRequest(
      email: email,
      password: password,
    );
    var response = await http.post(url, body: requestBody.toJson());
    return AuthResultEntity.fromJson(jsonDecode(response.body));
  }

  //   Future<AuthResultEntity> checkemail(String email) async {
  //     //https://abdulrahmanantar.com/outbye/auth/signup.php
  //     Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.checkemail);
  //     var requestBody = CheckEmailRequest(
  //       email: email,
  //     );
  //     var response = await http.post(url, body: requestBody.toJson());
  //     return AuthResultEntity.fromJson(jsonDecode(response.body));
  //   }

  //email forgetPassword
  Future<AuthResultEntity> checkemail(
      String email
      ) async {
    //https://abdulrahmanantar.com/outbye/forgetpassword/checkemail.php
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.checkemail);
    var requestBody = CheckEmailRequest(
      email: email,
    );
    var response = await http.post(url, body: requestBody.toJson());
    return AuthResultEntity.fromJson(jsonDecode(response.body));
  }


// Verify Code API
  Future<AuthResultEntity> verifyCode(String email, String verifyCode) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.verifyCodeApi);
    var requestBody = OtpRequest(
      email: email,
      verifycode: verifyCode,
    );
    var response = await http.post(url, body: requestBody.toJson());

    return AuthResultEntity.fromJson(jsonDecode(response.body));
  }


  Future<AuthResultEntity> verifyCodeForgetPassword(String email, String verifycode) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.verifyCodeForgetPassword);
    var requestBody = OtpScreenForgetPassword(
      email: email,
      verifycode: verifycode,
    );
    print("🔍 Server Response: $requestBody");
    var response = await http.post(url, body: requestBody.toJson());

    return AuthResultEntity.fromJson(jsonDecode(response.body));
  }

}