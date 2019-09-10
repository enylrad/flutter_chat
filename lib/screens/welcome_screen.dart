import 'package:flutter/material.dart';

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
            buildTitle(),
            SizedBox(height: 48.0,),
            getButton(Colors.lightBlueAccent, 'Log in', () => {}),
            getButton(Colors.blueAccent, 'Sign up', () => {})
          ],
        ),
      ),
    );
  }

  Widget getButton(
      MaterialAccentColor color, String name, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
          color: color,
          borderRadius: BorderRadius.circular(30.0),
          elevation: 5.0,
          child: SizedBox(
            height: 43.0,
            child: FlatButton(
              onPressed: onPressed,
              child: Text(name),
            ),
          )),
    );
  }

  Widget buildTitle() {
    return Row(
      children: <Widget>[
        Image.asset('images/icon_chat.png'),
        Container(
          margin: EdgeInsets.only(left: 10.0),
        ),
        Text(
          'Flutter Chat',
          style: TextStyle(
            fontSize: 45.0,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
