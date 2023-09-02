import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/models/user.dart';
import 'package:firebase_demo/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create User object for Firebase
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map((user) => _userFromFirebaseUser(user));
  }

//sign in anon
  Future signInAnon() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      User? user = credential.user;
      return user;
    } catch (e) {
      print('$e ');
      return null;
    }
  }

//sign in with email and password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('$e');
      return null;
    }
  }

//register with email and password

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;

      //create a document for the user with the uid
      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('$e');
      return null;
    }
  }

//sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('$e error done here');
    }
  }
}
