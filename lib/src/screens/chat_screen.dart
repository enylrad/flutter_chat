import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/src/services/authentication.dart';
import 'package:flutter_chat/src/services/message_service.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final auth = FirebaseAuth.instance;
  FirebaseUser loggedUser;
  TextEditingController _messageController = TextEditingController();

  InputDecoration _messageTextFieldDecoration = InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      hintText: "Enter text here...",
      border: InputBorder.none);

  BoxDecoration _messageContainerDecoration = BoxDecoration(
      border:
          Border(top: BorderSide(color: Colors.lightBlueAccent, width: 2.0)));

  TextStyle _sendButtonStyle = TextStyle(
      color: Colors.lightBlueAccent,
      fontWeight: FontWeight.bold,
      fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _getMessages();
  }

  void _getCurrentUser() async {
    try {
      Authentication().getCurrentUser().then((user) {
        if (user != null) {
          loggedUser = user;
        }
      });
    } catch (e) {}
  }

  void _getMessages() async {
    await for (var snapshot in MessageService().getMessagesStream()) {
      for (var message in snapshot.documents) {
        print(message.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
              Authentication().singOut();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: MessageService().getMessagesStream(),
              builder: (context, snapshot) {
                List<Text> messageWidgets = [];
                if (snapshot.hasData) {
                  var messages = snapshot.data.documents;
                  for (var message in messages) {
                    final messageValue = message.data["value"];
                    final messageSender = message.data["sender"];
                    messageWidgets.add(Text('$messageValue de $messageSender',
                    style: TextStyle(fontSize: 16.0),));
                  }
                } else {}
                return Flexible(
                    child: ListView(
                  children: messageWidgets,
                ));
              },
            ),
            Container(
              decoration: _messageContainerDecoration,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: _messageTextFieldDecoration,
                      controller: _messageController,
                    ),
                  ),
                  FlatButton(
                    child: Text("Send", style: _sendButtonStyle),
                    onPressed: _sendMessage,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    MessageService().save(collectionValues: {
      'value': _messageController.text,
      'sender': loggedUser.uid
    });
  }
}
