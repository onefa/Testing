import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterproarea/src/weather_base_item.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> singInFirebase (String email, String password) async {

    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return User.fromFirebase(user);
    } catch(e) {
      return null;
    }

  }
  Future<User> registerInFirebase (String email, String password) async {

    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return User.fromFirebase(user);
    } catch(e) {
      return null;
    }

  }

  Future logOutFirebase() async {
    await _firebaseAuth.signOut();
  }

  Stream<User> get currentFirebaseUser {
    return _firebaseAuth.onAuthStateChanged
        .map((FirebaseUser user) => user != null ? User.fromFirebase(user) : null );
  }

}