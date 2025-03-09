import 'package:graduation_project/auth/data/model/response/RegisterResponse.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {
  String? loadingMassage;
  RegisterLoadingState({this.loadingMassage});
}

class RegisterSuccessState extends RegisterState {
  AuthResultEntity response;
  RegisterSuccessState({required this.response});
}

class RegisterErrorState extends RegisterState {
  String? errorMessage;
  RegisterErrorState({this.errorMessage});
}
