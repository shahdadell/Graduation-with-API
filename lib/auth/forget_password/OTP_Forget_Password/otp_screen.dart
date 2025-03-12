import 'package:flutter/material.dart';
import 'package:graduation_project/Home_Screen/UI/home_screen.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/auth/data/api/api_manager.dart';
import 'package:graduation_project/auth/forget_password/reserpassword/ResetPassword.dart';
import 'package:graduation_project/auth/sign_up_screen/sign_up_screen.dart';

import 'text_filed_otp_screem.dart';

class OtpScreenForgetPassword extends StatefulWidget {
  static const String routName = 'otpScreenf';

  const OtpScreenForgetPassword({
    super.key,
  });

  @override
  State<OtpScreenForgetPassword> createState() =>
      _OtpScreenForgetPasswordState();
}

class _OtpScreenForgetPasswordState extends State<OtpScreenForgetPassword> {
  ApiManager apiManager = ApiManager.getInstance();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();
  final TextEditingController otpController5 = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // Add listeners to OTP controllers
    otpController1.addListener(_checkOtpFields);
    otpController2.addListener(_checkOtpFields);
    otpController3.addListener(_checkOtpFields);
    otpController4.addListener(_checkOtpFields);
    otpController5.addListener(_checkOtpFields);
  }

  void _checkOtpFields() {
    // Check if all OTP fields are filled
    setState(() {
      _isButtonEnabled = otpController1.text.isNotEmpty &&
          otpController2.text.isNotEmpty &&
          otpController3.text.isNotEmpty &&
          otpController4.text.isNotEmpty &&
          otpController5.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    // Dispose controllers when no longer needed
    otpController1.dispose();
    otpController2.dispose();
    otpController3.dispose();
    otpController4.dispose();
    otpController5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(15),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Enter Otp",
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
              onPressed: _isButtonEnabled
                  ? () async {
                print("OTP Continue Button Pressed");

                if (formKey.currentState!.validate()) {
                  String otpCode =
                      "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}${otpController5.text}";

                  print("Entered OTP: $otpCode");

                  var response = await apiManager
                      .verifyCodeForgetPassword(email, otpCode);

                  print(
                      "API Response: ${response.status}, Message: ${response.message}");

                  if (response.status == "success") {
                    print(
                        "Verification Successful! Navigating to Reset Password...");
                    Navigator.of(context)
                        .pushReplacementNamed(ResetPassword.routName);
                  } else {
                    print("Verification Failed: ${response.message}");
                  }
                }
              }
                  : null, // Disable button if _isButtonEnabled is false
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
    );
  }
}

