import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/repository/repository/auth_repository_contract.dart';
import 'forgetpassword_state.dart';

class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  ForgetPasswordViewModel({required this.repositoryContract})
      : super(ForgetPasswordInitialState());
  TextEditingController emailController = TextEditingController();

  bool? value = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthRepositoryContract repositoryContract;

  void ForgetPassword(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      try {
        emit(ForgetPasswordLoadingState(forgetpasswordMassage: "Loading..."));
        var response = await repositoryContract.checkemail(
          emailController.text,
        );
        if (response.status == 'failure') {
          emit(ForgetPasswordErrorState(forgetpasswordErrorMessage: response.message));
        } else {
          emit(ForgetPasswordSuccessState(response: response));
        }
      } catch (e) {
        print("Error :=> $e");
        emit(ForgetPasswordErrorState(forgetpasswordErrorMessage: e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
