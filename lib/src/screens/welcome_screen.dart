import 'package:flutter/material.dart';
import 'package:flutter_chat/src/screens/login_screen.dart';
import 'package:flutter_chat/src/screens/registration_screen.dart';
import 'package:flutter_chat/src/widgets/app_button.dart';
import 'package:flutter_chat/src/widgets/app_icon.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
            AppButton(
                color: Colors.lightBlueAccent,
                name: 'Log in',
                onPressed: () =>
                    Navigator.pushNamed(context, LoginScreen.routeName)),
            AppButton(
                color: Colors.blueAccent,
                name: 'Sign up',
                onPressed: () =>
                    Navigator.pushNamed(context, RegistrationScreen.routeName)),
      ],
        ),
      ),
    );
  }
}
