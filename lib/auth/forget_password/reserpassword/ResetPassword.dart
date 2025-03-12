import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  static const String routName = 'reset' ;
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(15),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Reset Password",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
