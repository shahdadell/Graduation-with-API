import 'package:flutter/material.dart';
import 'package:graduation_project/App_Images/app_images.dart';
import 'package:graduation_project/Home_Screen/UI/home_screen.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/auth/sign_up_screen/sign_up_screen.dart';
import 'package:graduation_project/auth/sing_in_screen/sign_in_screen.dart';

class MainScreen extends StatelessWidget {
  static const String routName = 'LoginScreen';
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery2 = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          AppImages.rectangle,
          width: mediaQuery2.width,
          height: mediaQuery2.height,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0x90f26b0a),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: const Text(
                    textAlign: TextAlign.center,
                    "visiting as a guest",
                    style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            leadingWidth: 160,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      AppImages.logo,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    AppImages.text,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(SignInScreen.routName);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(11),
                      backgroundColor: MyTheme.orangeColor,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Sign in",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Image.asset(
                          AppImages.divider,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          "or",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Image.asset(
                          AppImages.divider,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context)
                      //     .pushReplacementNamed(HomeScreen.routName);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(11),
                      backgroundColor: MyTheme.blueColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.google,
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          textAlign: TextAlign.center,
                          "Continue with Google",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context)
                      //     .pushReplacementNamed(HomeScreen.routName);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(11),
                      backgroundColor: MyTheme.blueColor2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.facebook,
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          textAlign: TextAlign.center,
                          "Continue with FaceBook",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context)
                      //     .pushReplacementNamed(HomeScreen.routName);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(11),
                      backgroundColor: MyTheme.blackColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.apple,
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          textAlign: TextAlign.center,
                          "Continue with Apple",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(SignUpScreen.routName);
                        },
                        child: const Text(
                          " Sign Up",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xffe37222),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
