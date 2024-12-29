import 'package:flutter/material.dart';
import 'package:messages_app/componenets/chat_bubble.dart';
import 'package:messages_app/componenets/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messages_app/services/auth/auth_service.dart';
import 'package:messages_app/services/auth/chat/chat_services.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});
  // text controller

  final TextEditingController _messageController = TextEditingController();
  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  // send Message

  void sendMessage() async {
    
    if (_messageController.text.isNotEmpty) {
      //send message
   
      await _chatService.sendMessage(receiverID, _messageController.text);
     
      // clear controller
      _messageController.clear();
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          // display messages
          Expanded(
            child: _buildMessageList(),
          ),

          // user input
          _buildUserInput()
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderID),
        builder: (context, snapshot) {
          // errors
          if (snapshot.hasError) {
            return const Text("Error");
          }
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }
          // return list view
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    //align message to right side
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(isCurrentUser: isCurrentUser, message: data["message"])
        ],
      ),
      alignment: alignment,
    );
  }

  // build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          // textfireld
          Expanded(
              child: MyTextfield(
                  hintText: "Type a message ",
                  obscureText: false,
                  controller: _messageController)),

          /// send button
          Container(
              decoration:
                  BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              margin: EdgeInsets.only(right: 25),
              child: IconButton(
                  onPressed: sendMessage,
                  icon: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
