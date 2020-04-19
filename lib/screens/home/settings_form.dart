import 'package:firebase_proj/models/user.dart';
import 'package:firebase_proj/services/database.dart';
import 'package:firebase_proj/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, dataStream) {
          if (dataStream.hasData) {
            UserData userData = dataStream.data;
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Update the data",
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: InputDecoration(
                        hintText: "Name",
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.pink, width: 2))),
                    validator: (val) =>
                        val.isNotEmpty ? null : "Please enter a name",
                    onChanged: (val) {
                      _currentName = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.all(12.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink, width: 2.0),
                      ),
                    ),
                    value: _currentSugar ?? dataStream.data.sugar,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _currentSugar = val;
                      });
                    },
                  ),
                  Slider(
                    min: 100,
                    max: 900,
                    divisions: 8,
                    value: (_currentStrength ?? userData.data).toDouble(),
                    onChanged: (val) {
                      setState(() {
                        _currentStrength = val.round();
                      });
                    },
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.data],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.data],
                  ),
                  RaisedButton(
                    color: Colors.pink,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: userData.uid).updateUserData(
                            _currentName ?? userData.name,
                            _currentSugar ?? userData.sugar,
                            _currentStrength ?? userData.data);
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
