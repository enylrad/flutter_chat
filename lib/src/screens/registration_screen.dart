import 'package:flutter/material.dart';
import 'package:flutter_chat/src/widgets/app_button.dart';
import 'package:flutter_chat/src/widgets/app_icon.dart';
import 'package:flutter_chat/src/widgets/app_textfield.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = '/registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
              hint: 'Enter email',
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 8.0,
            ),
            AppTextField(
              hint: 'Enter password',
              obscure: true,
            ),
            SizedBox(
              height: 23.0,
            ),
            AppButton(
              color: Colors.blueAccent,
              onPressed: () {},
              name: 'Sign up',
            )
          ],
        ),
      ),
    );
  }
}
