
import 'package:flutter/material.dart';
import 'package:messages_app/services/auth/auth_service.dart';
import 'package:messages_app/services/auth/chat/chat_services.dart';

import '../componenets/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});
  // chat auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  

  void logout() {
    // get auth services
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHATS"),
        actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
      ),
      drawer: Drawer(),
      body: _buildUserList(),
    );
  }

  // build a list of users except the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          // error
          if (snapshot.hasError) {
            return const Text("Error");
          }
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }
          // return list view
          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _buildUserListItem(userData, context ))
                .toList(),
          );
        });
  }

  //build indivisual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users except current user
    if(userData["email"] != _authService.getCurrentUser()!.email){
      return UserTile(
      text: userData["email"],
      onTap: () {
        // tapped a user -> go to chat page
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID : userData["uid"]
              ),
            ));
      },
    );
    } else{
      return Container();
    }
  }
}
