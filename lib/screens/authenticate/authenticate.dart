import 'package:firebase_proj/screens/authenticate/register.dart';
import 'package:firebase_proj/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isSignedup = true;

  void toggleSignUp() {
    setState(() {
      isSignedup = !isSignedup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSignedup
        ? SignIn(
            onToggle: toggleSignUp,
          )
        : Register(
            onToggle: toggleSignUp,
          );
  }
}
