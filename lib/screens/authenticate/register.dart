import 'package:flutter/material.dart';
import 'package:firebase_proj/services/auth.dart';
import 'package:firebase_proj/shared/loading.dart';

class Register extends StatefulWidget {
  Register({this.onToggle});

  final onToggle;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "", password = "", error = "";

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
              title: Text("Sign up"),
              actions: <Widget>[
                RaisedButton(
                  onPressed: widget.onToggle,
                  child: Text("Sign in!"),
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
                        validator: (val) =>
                            val.isNotEmpty ? null : "Enter a valid email",
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
                        validator: (val) =>
                            val.length < 6 ? "Enter a longer password" : null,
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
                                await _authService.register(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = "Enter a valid email";
                              });
                            }
                          }
                        },
                        child: Text(
                          "Register",
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
