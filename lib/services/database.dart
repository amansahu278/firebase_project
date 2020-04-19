import 'dart:async';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_proj/models/collectionData.dart';
import 'package:firebase_proj/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference _collection = Firestore.instance.collection('data');

  Future updateUserData(String name, String sugar, int data) async {
    return await _collection
        .document(uid)
        .setData({'name': name, 'sugar': sugar, 'data': data});
  }

  // collectionData from snapshot

  List<CollectionData> _collectionDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return CollectionData(
          name: doc.data['name'] ?? "Some Name",
          sugar: doc.data['sugar'] ?? "0",
          data: doc['data'] ?? 0);
    }).toList();
  }

  /*
  Stream<QuerySnapshot> get collection{
    return _collection.snapshots();
  }
  */

  Stream<List<CollectionData>> get collection {
    return _collection.snapshots().map(_collectionDataFromSnapshot);
  }

  /*
  // get user doc stream
  Stream<DocumentSnapshot> get userData {
    return _collection.document(uid).snapshots();
  }
``*/
  // get user doc stream
  Stream<UserData> get userData {
    return _collection
        .document(uid)
        .snapshots()
        .map(_userDataFromDocumentSnapshot);
  }

  //get userData
  UserData _userDataFromDocumentSnapshot(DocumentSnapshot snap) {
    return UserData(
      uid: uid,
      sugar: snap.data['sugar'],
      data: snap.data['data'],
      name: snap.data['name'],
    );
  }
}
