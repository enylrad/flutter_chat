import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final TextInputType textInputType;

  AppTextField({this.hint, this.textInputType, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
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
    );
  }
}
