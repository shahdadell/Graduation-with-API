import 'package:graduation_project/auth/data/model/response/RegisterResponse.dart';

abstract class ForgetPasswordState {}

class ForgetPasswordInitialState extends ForgetPasswordState {}

class ForgetPasswordLoadingState extends ForgetPasswordState {
  String? forgetpasswordMassage;
  ForgetPasswordLoadingState({this.forgetpasswordMassage});
}

class ForgetPasswordSuccessState extends ForgetPasswordState {
  AuthResultEntity response;
  ForgetPasswordSuccessState({required this.response});
}

class ForgetPasswordErrorState extends ForgetPasswordState {
  String? forgetpasswordErrorMessage;
  ForgetPasswordErrorState({this.forgetpasswordErrorMessage});
}