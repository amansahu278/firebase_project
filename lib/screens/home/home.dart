import 'package:firebase_proj/screens/home/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_proj/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_proj/services/database.dart';
import 'displist.dart';
import 'package:firebase_proj/models/collectionData.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: (context),
          builder: (context) {
            return Container(padding: EdgeInsets.all(8), child: SettingsForm());
          });
    }

    return StreamProvider<List<CollectionData>>.value(
      value: DatabaseService().collection,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                _showSettingsPanel();
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'), fit: BoxFit.cover),
          ),
          child: DispList(),
        ),
      ),
    );
  }
}
