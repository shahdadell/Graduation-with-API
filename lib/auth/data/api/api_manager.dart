import 'dart:convert';
import 'package:graduation_project/auth/data/model/request/LoginRequest.dart';
import 'package:graduation_project/auth/data/model/request/OtpRequest.dart';
import 'package:http/http.dart' as http;
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
  // try {
  //   final response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode(body),
  //   );
  //   return response;
  // } catch (e) {
  //   throw Exception('Failed to verify code: $e');

  // static Future<HomeScreen> getSources() async {
  //   Uri url = Uri.https(
  //     ApiConstants.baseUrl,
  //     ApiConstants.sourceApi,
  //   );
  //   try{
  //     var response = await http.get(url);
  //     var bodyString = response.body;
  //     var json = jsonDecode(bodyString);
  //     return HomeScreen.fromJson(json);
  //   }catch (e){
  //     throw e ;
  //   }
  // }
}