import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Theme/dialog_utils.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/auth/data/api/api_manager.dart';
import 'package:graduation_project/auth/data/repository/auth_repository/data_source/auth_remote_data_source_impl.dart';
import 'package:graduation_project/auth/data/repository/auth_repository/repository/auth_repository_impl.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';
import 'package:graduation_project/auth/forget_password/cubit/ForgetPassword_ViewModel.dart';
import 'package:graduation_project/auth/sing_in_screen/text_filed_login.dart';
import 'OTP_Forget_Password/otp_screen.dart';
import 'cubit/forgetpassword_state.dart';



class ForgetPassword extends StatefulWidget {
  static const String routName = 'ForgetPassword';

  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  ForgetPasswordViewModel viewmodel = ForgetPasswordViewModel(
    repositoryContract: injectAuthRepositoryContract(),
  );

  late TextEditingController emailController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordViewModel, ForgetPasswordState>(
      bloc: viewmodel,
      listener: (context, state) {
        if (state is ForgetPasswordLoadingState) {
          DialogUtils.showLoading(context, state.forgetpasswordMassage!);
        } else if (state is ForgetPasswordErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, state.forgetpasswordErrorMessage!,
              posActionName: 'Ok');
        } else if (state is ForgetPasswordSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, state.response.message ?? '',
              posActionName: 'Ok', posAction: () {
                Navigator.of(context).pushReplacementNamed(
                  OtpScreenForgetPassword.routName,
                  arguments: viewmodel.emailController.text,
                );
              });
        }
      },

      child: Scaffold(
        body: Form(
          key: viewmodel.formKey, // استخدام formKey من viewmodel
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Email Address",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  TextFiledLogin(
                    text: 'User name / Email',
                    type: TextInputType.emailAddress,
                    action: TextInputAction.done,
                    icon: Icons.email,
                    controller: viewmodel.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "E-mail is required";
                      }
                      bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return 'PLease Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      viewmodel.ForgetPassword(
                          context
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(11),
                      backgroundColor: MyTheme.orangeColor,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Continue",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

AuthRepositoryContract injectAuthRepositoryContract() {
  return AuthRepositoryImpl(
      remoteDataSource:
      AuthRemoteDataSourceImpl(apiManager: ApiManager.getInstance()));
}