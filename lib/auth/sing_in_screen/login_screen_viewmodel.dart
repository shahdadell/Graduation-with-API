import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';
import 'package:graduation_project/auth/sing_in_screen/login_state.dart';


class LoginScreenViewmodel extends Cubit<LoginState> {
  LoginScreenViewmodel({required this.repositoryContract})
      : super(LoginInitialState());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool? value = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthRepositoryContract repositoryContract;

  void SignIn(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      try {
        emit(LoginLoadingState(loadingMassage: "Loading..."));
        var response = await repositoryContract.login(
          emailController.text,
          passwordController.text
        );
        if (response.status == 'failure') {
          emit(LoginErrorState(errorMessage: response.message));
        } else {
          emit(LoginSuccessState(response: response));
        }
      } catch (e) {
        print("Error :=> $e") ;
        emit(LoginErrorState(errorMessage: e.toString()));
      }
    }
  }

  // دالة لإغلاق الـ controllers بشكل صحيح
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}