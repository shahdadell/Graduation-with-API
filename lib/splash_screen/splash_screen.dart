import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graduation_project/Main_Screen/main_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routName = "SplashScreen";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const MainScreen();
          },
        ),
      );
    });
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Image.asset(
        "assets/images/copy.gif",
        width: mediaQuery.width,
        height: mediaQuery.height,
        fit: BoxFit.cover,
      ),
    );
  }
}
