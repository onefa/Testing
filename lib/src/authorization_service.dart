import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutterproarea/src/weather_base_item.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'api_key.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: ['email'],
    clientId: ApiKey().clientID,
  );
  FacebookLogin facebookLogin = FacebookLogin();


  Future<User> singInFirebase (String email, String password) async {

    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return User.fromFirebase(user);
    } catch(e) {
      print(e);
      return null;
    }

  }

  Future<User> registerInFirebase (String email, String password) async {

    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return User.fromFirebase(user);
    } catch(e) {
      print(e);
      return null;
    }

  }

  Future<User> loginGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential =
    GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    try {
      final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
      FirebaseUser user = authResult.user;
      return User.fromFirebase(user);
    } catch(e) {
      print(e);
      return null;
    }

  }

  Future<User> loginFacebook() async {
    var facebookLoginResult =
    await facebookLogin.logIn(['email']);

    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {

        final token = facebookLoginResult.accessToken.token;
        final credential = FacebookAuthProvider.getCredential(accessToken: token);

        try {
          final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
          FirebaseUser user = authResult.user;
          return User.fromFirebase(user);
        } catch(e) {
          print(e);
          return null;
        }
    } else {
      return null;
    }
  }


  Future logOutFirebase() async {
    await _googleSignIn.signOut();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }

  Stream<User> get currentFirebaseUser {
    return _firebaseAuth.onAuthStateChanged
        .map((FirebaseUser user) => user != null ? User.fromFirebase(user) : null );
  }

}