import 'package:budget_buddy/pages/login.dart';
import 'package:budget_buddy/pages/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLogin = true;

  void toggleScreens() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return Login(showRegisterPage: toggleScreens);
    } else {
      return RegisterPage(showLogin: toggleScreens);
    }
  }
}
