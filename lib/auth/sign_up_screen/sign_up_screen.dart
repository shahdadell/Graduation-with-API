import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/App_Images/app_images.dart';
import 'package:graduation_project/Main_Screen/main_screen.dart';
import 'package:graduation_project/Theme/dialog_utils.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/auth/OTP/otp_screen.dart';
import 'package:graduation_project/auth/data/api/api_manager.dart';
import 'package:graduation_project/auth/data/repository/auth_repository/data_source/auth_remote_data_source_impl.dart';
import 'package:graduation_project/auth/data/repository/auth_repository/repository/auth_repository_impl.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';
import 'package:graduation_project/auth/sign_up_screen/text_filed_siginup.dart';
import 'cubit/register_screen_viewmodel.dart';
import 'cubit/register_state.dart';

class SignUpScreen extends StatefulWidget {
  static const String routName = 'SignUpScreen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  RegisterScreenViewmodel viewmodel = RegisterScreenViewmodel(
    repositoryContract: injectAuthRepositoryContract(),
  );

  //
  // @override
  // void dispose() {
  //   super.dispose();
  //   nameController.dispose();
  //   emailController.dispose();
  //   phoneController.dispose();
  //   passwordController.dispose();
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   nameController = TextEditingController();
  //   emailController = TextEditingController();
  //   phoneController = TextEditingController();
  //   passwordController = TextEditingController();
  // }
  //
  // @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterScreenViewmodel, RegisterState>(
      bloc: viewmodel,
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          DialogUtils.showLoading(context, state.loadingMassage!);
        } else if (state is RegisterErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, state.errorMessage!,
              posActionName: 'Ok');
        } else if (state is RegisterSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, state.response.message ?? '',
              posActionName: 'Ok', posAction: () {
            Navigator.of(context).pushReplacementNamed(
              OtpScreen.routName,
              arguments: viewmodel.emailController.text,
            );
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(MainScreen.routName);
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Icon(
                Icons.arrow_back_ios,
                color: MyTheme.blackColor,
                size: 30,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            "Sign up",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Form(
          key: viewmodel.formKey,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    AppImages.sign,
                    width: 170,
                    height: 170,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Email Address",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  TextFiledSingup(
                    text: 'User name / Email',
                    type: TextInputType.emailAddress,
                    action: TextInputAction.done,
                    icon: Icons.email,
                    hint: 'Enter Your User Name',
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
                  const SizedBox(height: 10),
                  Text(
                    "User Name",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  TextFiledSingup(
                    controller: viewmodel.userNameController,
                    text: 'User Name',
                    icon: Icons.person,
                    hint: 'Enter Your User Name',
                    type: TextInputType.name,
                    action: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "User Name is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Phone Number",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  TextFiledSingup(
                    controller: viewmodel.phoneController,
                    text: 'Phone Number',
                    icon: Icons.phone,
                    hint: 'Enter Your Phone Number',
                    type: TextInputType.phone,
                    action: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Phone Number is required";
                      }
                      if (value.length < 11) {
                        return "Phone Number Should Be At Least 11 Chars";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Password",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  TextFiledSingup(
                    controller: viewmodel.passwordController,
                    text: 'Password',
                    icon: Icons.remove_red_eye,
                    hint: 'Enter Your Password',
                    type: TextInputType.visiblePassword,
                    action: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      if (value.length < 6) {
                        return "Password Should Be At Least 6 Chars";
                      }
                      return null;
                    },
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        tristate: true,
                        value: viewmodel.value,
                        checkColor: MyTheme.whiteColor,
                        activeColor: MyTheme.orangeColor,
                        onChanged: (bool? newValue) {
                          setState(
                            () {
                              viewmodel.value = newValue;
                            },
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: SizedBox(
                          width: 300,
                          child: Image.asset(
                            "assets/images/check.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      viewmodel.SignUp(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(11),
                      backgroundColor: MyTheme.orangeColor,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Register",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 350,
                        child: Image.asset(
                          "assets/images/Separator2.png",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Image.asset(
                          AppImages.google,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Image.asset(
                          AppImages.facebook,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Image.asset(
                          "assets/images/ButtonApple.png",
                          width: 33,
                          height: 33,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(MainScreen.routName);
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Icon(
              Icons.arrow_back_ios,
              color: MyTheme.blackColor,
              size: 30,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Sign up",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Form(
        key: viewmodel.formKey,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppImages.sign,
                  width: 170,
                  height: 170,
                ),
                const SizedBox(height: 20),
                Text(
                  "Email Address",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                TextFiledSingup(
                  text: 'User name / Email',
                  type: TextInputType.emailAddress,
                  action: TextInputAction.done,
                  icon: Icons.email,
                  hint: 'Enter Your User Name',
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
                const SizedBox(height: 10),
                Text(
                  "User Name",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                TextFiledSingup(
                  controller: viewmodel.userNameController,
                  text: 'User Name',
                  icon: Icons.person,
                  hint: 'Enter Your User Name',
                  type: TextInputType.name,
                  action: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "User Name is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  "Phone Number",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                TextFiledSingup(
                  controller: viewmodel.phoneController,
                  text: 'Phone Number',
                  icon: Icons.phone,
                  hint: 'Enter Your Phone Number',
                  type: TextInputType.phone,
                  action: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone Number is required";
                    }
                    if (value.length < 11) {
                      return "Phone Number Should Be At Least 11 Chars";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  "Password",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                TextFiledSingup(
                  controller: viewmodel.passwordController,
                  text: 'Password',
                  icon: Icons.remove_red_eye,
                  hint: 'Enter Your Password',
                  type: TextInputType.visiblePassword,
                  action: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Password Should Be At Least 6 Chars";
                    }
                    return null;
                  },
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      tristate: true,
                      value: viewmodel.value,
                      checkColor: MyTheme.whiteColor,
                      activeColor: MyTheme.orangeColor,
                      onChanged: (bool? newValue) {
                        setState(
                          () {
                            viewmodel.value = newValue;
                          },
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: SizedBox(
                        width: 300,
                        child: Image.asset(
                          "assets/images/check.png",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(11),
                    backgroundColor: MyTheme.orangeColor,
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Register",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 350,
                      child: Image.asset(
                        "assets/images/Separator2.png",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        AppImages.google,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        AppImages.facebook,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "assets/images/ButtonApple.png",
                        width: 33,
                        height: 33,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

AuthRepositoryContract injectAuthRepositoryContract() {
  // تأكد من أنك مررت بيانات صحيحة للكائن الخاص بالمصدر البعيد
  return AuthRepositoryImpl(
      remoteDataSource:
          AuthRemoteDataSourceImpl(apiManager: ApiManager.getInstance()));
}