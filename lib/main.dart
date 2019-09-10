import 'package:flutter/material.dart';
import 'package:flutter_chat/src/screens/chat_screen.dart';
import 'package:flutter_chat/src/screens/registration_screen.dart';

import 'src/screens/login_screen.dart';
import 'src/screens/welcome_screen.dart';

void main() {
  runApp(MaterialApp(
    home: SafeArea(
      child: WelcomeScreen(),
    ),
    theme: ThemeData(
        textTheme: TextTheme(body1: TextStyle(color: Colors.black45))),
    initialRoute: WelcomeScreen.routeName,
    routes: <String, WidgetBuilder>{
      LoginScreen.routeName: (BuildContext context) => LoginScreen(),
      WelcomeScreen.routeName: (BuildContext context) => WelcomeScreen(),
      RegistrationScreen.routeName: (BuildContext context) =>
          RegistrationScreen(),
      ChatScreen.routeName: (BuildContext context) => ChatScreen()
    },
  ));
}
