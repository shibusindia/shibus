import 'package:firebase_auth/firebase_auth.dart';
import 'package:shibusindia/model/user.dart';
import 'package:shibusindia/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _userFromfirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromfirebaseUser);
  }

// login user
  Future login(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// register a user
  Future register(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // create a record on database
      await DatabaseService(uid: user.uid).setConfigData(
          username: 'username',
          secretkey: '',
          apikey: '',
          phone: '',
          telegramSettings: [],
          binanceData: null);

      return _userFromfirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// logout user
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
