import 'package:firebase_proj/services/auth.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'package:firebase_proj/shared/loading.dart';

class SignIn extends StatefulWidget {
  SignIn({this.onToggle});

  final onToggle;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //test field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              centerTitle: true,
              title: Text("Sign in"),
              actions: <Widget>[
                RaisedButton(
                  onPressed: widget.onToggle,
                  child: Text("Sign up!"),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Email",
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2))),
                        validator: (val) {
                          return val.isEmpty ? "Enter an email" : null;
                        },
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Password",
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2))),
                        validator: (val) {
                          return val.length < 6
                              ? "Enter a longer password"
                              : null;
                        },
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        color: Colors.black,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _authService.signIn(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = "Sign in error";
                              });
                            }
                          }
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
