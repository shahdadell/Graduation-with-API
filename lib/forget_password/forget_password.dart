import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/App_Images/app_images.dart';
import 'package:graduation_project/Theme/theme.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: MyTheme.grayColor2,
              ),
              width: 130,
              height: 4,
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Forgot Password ? ",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Image.asset(AppImages.pass)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
