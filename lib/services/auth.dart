import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_proj/models/user.dart';
import 'package:firebase_proj/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create User obj from FirebaseUser

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map((user) => _userFromFirebaseUser(user));
  }

  //sign in anonymous
  Future signInAnonymous() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser fuser = result.user;
      User user = _userFromFirebaseUser(fuser);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signIn(email, password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = _userFromFirebaseUser(result.user);

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future register(email, password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = _userFromFirebaseUser(result.user);
      //create a new document for the user
      await DatabaseService(uid: user.uid).updateUserData('', '', 100);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
