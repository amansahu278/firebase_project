import 'package:flutter/material.dart';
import 'package:firebase_proj/models/collectionData.dart';

class DataTile extends StatelessWidget {
  DataTile({this.instance});

  final CollectionData instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/coffee_icon.png'),
            radius: 25,
            backgroundColor: Colors.brown[instance.data],
          ),
          title: Text(instance.name),
          subtitle: Text('Takes: ${instance.sugar} sugar(s)'),
        ),
      ),
    );
  }
}
