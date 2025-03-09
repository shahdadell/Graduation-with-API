import 'package:graduation_project/auth/data/model/response/RegisterResponse.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {
  String? loadingMassage;
  LoginLoadingState({this.loadingMassage});
}

class LoginSuccessState extends LoginState {
  AuthResultEntity response;
  LoginSuccessState({required this.response});
}

class LoginErrorState extends LoginState {
  String? errorMessage;
  LoginErrorState({this.errorMessage});
}