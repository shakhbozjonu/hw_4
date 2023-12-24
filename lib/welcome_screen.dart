import 'package:flutter/material.dart';
import 'package:hw_4/user_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late SharedPreferences _prefs;
  bool _showWelcomeScreen = true;

  @override
  void initState() {
    super.initState();
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _showWelcomeScreen = _prefs.getBool('showWelcomeScreen') ?? true;
    });
  }

  void _disableWelcomeScreen() {
    _prefs.setBool('showWelcomeScreen', false);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_showWelcomeScreen) {
      return Container(); // Empty container if the welcome screen shouldn't be shown
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, you will not see this page again!'),
            ElevatedButton(
              onPressed: _disableWelcomeScreen,
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}