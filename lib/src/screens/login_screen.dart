import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/src/mixins/validator_mixins.dart';
import 'package:flutter_chat/src/screens/chat_screen.dart';
import 'package:flutter_chat/src/services/authentication.dart';
import 'package:flutter_chat/src/widgets/app_button.dart';
import 'package:flutter_chat/src/widgets/app_icon.dart';
import 'package:flutter_chat/src/widgets/app_textfield.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidatorMixins{
  TextEditingController _emailController;
  TextEditingController _passwordController;
  FocusNode _focusNode;
  bool _showProgress = false;
  bool _autovalidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  void setProgressStatus(bool status) {
    setState(() {
      _showProgress = status;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: _showProgress,
      child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AppIcon(),
                SizedBox(height: 48.0),
                _emailField(),
                SizedBox(height: 8.0),
                _passwordField(),
                SizedBox(height: 23.0),
                _submitButton(context)
              ],
            ),
          )),
    ));
  }

  Widget _emailField() {
    return AppTextField(
      hint: "Enter email",
      focusNode: _focusNode,
      textInputType: TextInputType.emailAddress,
      validator: validateEmail,
      controller: _emailController,
      autoValidate: _autovalidate,
    );
  }

  Widget _passwordField() {
    return AppTextField(
      hint: "Enter password",
      obscure: true,
      validator: validatePassword,
      controller: _passwordController,
      autoValidate: _autovalidate,
    );
  }

  Widget _submitButton(BuildContext context) {
    return AppButton(
        color: Colors.lightBlueAccent,
        name: 'Log in',
        onPressed: () async {
          if(_formKey.currentState.validate()) {
            setProgressStatus(true);
            final FirebaseUser user = await Authentication()
                .loginUser(email: _emailController.text, password: _passwordController.text);
            if (user != null) {
              Navigator.pushNamed(context, ChatScreen.routeName);
            }

            _autovalidate = false;
            FocusScope.of(context).requestFocus(_focusNode);
            _emailController.text = "";
            _passwordController.text = "";
            setProgressStatus(false);
          } else {
            setState(() {
              _autovalidate = true;
            });
          }
        });
  }
}
