import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_proj/models/collectionData.dart';
import 'datatile.dart';

class DispList extends StatefulWidget {
  @override
  _DispListState createState() => _DispListState();
}

class _DispListState extends State<DispList> {
  @override
  Widget build(BuildContext context) {
    final collection = Provider.of<List<CollectionData>>(context) ?? [];
    return ListView.builder(
        itemCount: collection.length,
        itemBuilder: (context, int index) {
          return DataTile(
            instance: collection[index],
          );
        });
  }
}
