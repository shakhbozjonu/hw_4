import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'user_list_screen.dart';
import 'saved_user_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Multi-Route App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/userList': (context) => UserListScreen(),
        '/savedUserList': (context) => SavedUserListScreen(),
      },
    );
  }
}