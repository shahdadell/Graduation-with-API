import 'package:flutter/material.dart';
import 'package:graduation_project/App_Images/app_images.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/auth/sign_up_screen/sign_up_screen.dart';
import 'package:graduation_project/auth/sing_in_screen/sign_in_screen.dart';

import '../Home_Screen/UI/home_screen.dart';

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
                      style: Theme.of(context).textTheme.displayMedium,
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
                          style: Theme.of(context).textTheme.displaySmall,
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
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        "Don't have an account? ",
                        textAlign: TextAlign.center,
                         style: Theme.of(context).textTheme.displaySmall,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(SignUpScreen.routName);
                        },
                        child:  Text(
                          " Sign Up",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routName);
                    },
                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: const Color(0x90f26b0a),
                    //   shape: ContinuousRectangleBorder(
                    //     borderRadius: BorderRadius.circular(40),
                    //   ),
                    // ),
                    child: Text(
                      textAlign: TextAlign.center,
                      "visiting as a guest",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
