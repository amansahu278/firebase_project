import 'package:firebase_proj/screens/authenticate/authenticate.dart';
import 'package:firebase_proj/screens/authenticate/sign_in.dart';
import 'package:firebase_proj/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_proj/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate

    //Listen to the stream
    final user = Provider.of<User>(context);
    print(user);
    if (user == null)
      return Authenticate();
    else
      return Home();
  }
}
