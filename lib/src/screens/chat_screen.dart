import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
        automaticallyImplyLeading: false,
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
                return Flexible(
                    child: ListView(
                  children: _getChatItems(snapshot.data.documents),
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

  List<ChatItem> _getChatItems(dynamic messages) {
    List<ChatItem> chatItems = [];
    for (var message in messages) {
      final messageValue = message.data["value"];
      final messageSender = message.data["sender"];
      chatItems.add(ChatItem(
          message: messageValue,
          sender: messageSender,
          isMe: messageSender == loggedUser.email));
    }
    return chatItems;
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      MessageService().save(collectionValues: {
        'value': _messageController.text,
        'sender': loggedUser.email,
        'timestamps': FieldValue.serverTimestamp()
      });
      _messageController.clear();
    }
  }
}

class ChatItem extends StatelessWidget {
  final String sender;
  final String message;
  final bool isMe;

  ChatItem({this.sender, this.message, this.isMe});

  @override
  Widget build(BuildContext context) {
    var alignment = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    var backgroundColor = isMe ? Colors.blueAccent : Colors.white;
    var textColor = isMe ? Colors.white : Colors.black54;
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          Material(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)),
              elevation: 5.0,
              color: backgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 16.0, color: textColor),
                ),
              ))
        ],
      ),
    );
  }
}
