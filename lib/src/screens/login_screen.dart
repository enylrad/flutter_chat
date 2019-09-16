import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/src/screens/chat_screen.dart';
import 'package:flutter_chat/src/services/authentication.dart';
import 'package:flutter_chat/src/widgets/app_button.dart';
import 'package:flutter_chat/src/widgets/app_icon.dart';
import 'package:flutter_chat/src/widgets/app_textfield.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              textInputType: TextInputType.emailAddress,
              onChanged: (value) => _email = value,
            ),
            SizedBox(
              height: 8.0,
            ),
            AppTextField(
              hint: "Enter password",
              obscure: true,
              onChanged: (value) => _password = value,
            ),
            SizedBox(
              height: 23.0,
            ),
            AppButton(
                color: Colors.lightBlueAccent,
                name: 'Log in',
                onPressed: () async {
                  final FirebaseUser user = await Authentication()
                      .loginUser(email: _email, password: _password);
                  if (user != null) {
                    Navigator.pushNamed(context, ChatScreen.routeName);
                  }
                })
          ],
        ),
      ),
    );
  }
}
