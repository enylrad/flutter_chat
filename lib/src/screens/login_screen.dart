import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  FocusNode _focusNode;
  bool _showProgress = false;

  void setProgressStatus(bool status){
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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppIcon(),
            SizedBox(
              height: 48.0,
            ),
            AppTextField(
              hint: "Enter email",
              focusNode: _focusNode,
              textInputType: TextInputType.emailAddress,
              onChanged: (value) => _email = value,
              controller: _emailController,
            ),
            SizedBox(
              height: 8.0,
            ),
            AppTextField(
              hint: "Enter password",
              obscure: true,
              onChanged: (value) => _password = value,
              controller: _passwordController,
            ),
            SizedBox(
              height: 23.0,
            ),
            AppButton(
                color: Colors.lightBlueAccent,
                name: 'Log in',
                onPressed: () async {
                  setProgressStatus(true);
                  final FirebaseUser user = await Authentication()
                      .loginUser(email: _email, password: _password);
                  if (user != null) {
                    Navigator.pushNamed(context, ChatScreen.routeName);
                  }
                  FocusScope.of(context).requestFocus(_focusNode);
                  _emailController.text = "";
                  _passwordController.text = "";
                  setProgressStatus(false);
                })
          ],
        ),
      ),
    ));
  }
}
