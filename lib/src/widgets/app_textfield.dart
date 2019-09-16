import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  final bool obscure;
  final TextInputType textInputType;
  final TextEditingController controller;
  final FocusNode focusNode;

  AppTextField(
      {this.hint,
      this.onChanged,
      this.textInputType,
      this.obscure = false,
      this.controller,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      obscureText: obscure,
      keyboardType: textInputType,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(color: Colors.blueAccent, width: 2.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)))),
      onChanged: onChanged,
      textAlign: TextAlign.center,
    );
  }
}
