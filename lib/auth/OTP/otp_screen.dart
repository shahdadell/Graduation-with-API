import 'package:flutter/material.dart';
import 'package:graduation_project/Home_Screen/UI/home_screen.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/auth/data/api/api_manager.dart';
import 'package:graduation_project/auth/sign_up_screen/sign_up_screen.dart';

import 'text_filed_otp_screem.dart';

class OtpScreen extends StatefulWidget {
  static const String routName = 'otp';

  const OtpScreen({
    super.key,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  ApiManager apiManager = ApiManager.getInstance();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();
  final TextEditingController otpController5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(SignUpScreen.routName);
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
          "Enter Otp ",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter The Confirmation code",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Form(
                key: formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 70,
                      child: TextFiledOtpScreen(
                        controller: otpController1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Verification code is required";
                          }
                          if (value != otpController1.value) {
                            return "Doesn't Match";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 70,
                      child: TextFiledOtpScreen(
                        controller: otpController2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Verification code is required";
                          }
                          if (value != otpController2.value) {
                            return "Doesn't Match";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 70,
                      child: TextFiledOtpScreen(
                        controller: otpController3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Verification code is required";
                          }
                          if (value != otpController3.value) {
                            return "Doesn't Match";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 70,
                      child: TextFiledOtpScreen(
                        controller: otpController4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Verification code is required";
                          }
                          if (value != otpController4.value) {
                            return "Doesn't Match";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 70,
                      child: TextFiledOtpScreen(
                        controller: otpController5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Verification code is required";
                          }
                          if (value != otpController5.value) {
                            return "Doesn't Match";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Verification code has been sent to your email",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  var response = await apiManager.verifyCode(email,
                      "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}${otpController5.text}");
                  if (response.status == "success") {
                    Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
                  }else {
                    print("Failed :=> ${response.message}");
                  }
                } // otp();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(11),
                backgroundColor: MyTheme.orangeColor,
              ),
              child: Text(
                textAlign: TextAlign.center,
                "Continue",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}