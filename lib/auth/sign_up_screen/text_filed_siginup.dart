import 'package:flutter/material.dart';

class TextFiledSingup extends StatelessWidget {
  TextEditingController controller;
  String hint;
  String text;
  IconData icon;
  TextInputType type;
  TextInputAction action;
  String? Function(String?)? validator;
  bool password;

  TextFiledSingup({
    super.key,
    required this.icon,
    required this.hint,
    required this.type,
    required this.text,
    required this.action,
    required this.controller,
    required this.validator,
    this.password = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: password,
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
