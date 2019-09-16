import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onSaved;
  final bool obscure;
  final TextInputType textInputType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autoValidate;
  final FormFieldValidator<String> validator;

  AppTextField(
      {this.hint,
      this.onSaved,
      this.textInputType,
      this.obscure = false,
      this.controller,
      this.validator,
      this.focusNode,
      this.autoValidate});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidate: autoValidate,
      validator: validator,
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
      onSaved: onSaved,
      textAlign: TextAlign.center,
    );
  }
}
