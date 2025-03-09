// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
// import 'package:graduation_project/Theme/theme.dart';

class TextFiledLogin extends StatelessWidget {
  String text;
  IconData icon;
  TextInputType type;
  TextInputAction action;
  TextEditingController controller;
  String? Function(String?)? validator;
  bool password;
  bool isObsecure;

  TextFiledLogin({
    super.key,
    required this.text,
    required this.type,
    required this.action,
    required this.icon,
    required this.controller,
    required this.validator,
    this.password = false,
    this.isObsecure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsecure,
      validator: validator,
      controller: controller,
      keyboardType: type,
      textInputAction: action,
      decoration: InputDecoration(
        label: Text(
          text,
          style:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2,
            color: Color(0xffF87146),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffb80505),
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xffb80505),
            width: 1.2,
          ),
        ),
        suffixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
      ),
    );
  }
}
