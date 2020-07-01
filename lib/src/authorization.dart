
import 'package:flutter/material.dart';
import 'package:flutterproarea/src/api_key.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class AutorizationPage extends StatefulWidget {
  AutorizationPage({Key key}) : super (key: key);

  @override
  _AutorizationPageState createState() => _AutorizationPageState();
}

class _AutorizationPageState extends State<AutorizationPage> {


  FacebookLogin facebookLogin = FacebookLogin();

  GoogleSignIn _googleSignIn = new GoogleSignIn(
  //  scopes: [
    //  'email',
    //  'https://www.googleapis.com/auth/contacts.readonly',
  //  ],
    clientId: ApiKey().clientID,
  );

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _email;
  String _password;
  bool showLogin = true;
  bool isFBLoggedIn = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _logo(),
          _form('Login', _buttonAction),
        ],
      ),
    );
  }

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.only(top: 90),
      child: Container(
        child: Align(
          child: Text('ProArea',
          style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }

  Widget _form(String label, void func()) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: _input('email', _emailController, false),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: _input('password', _passwordController, true),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: button(label, func),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: () => doLogin(),
                child: Text('Login with Google'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: () => initiateFacebookLogin(),
                child: Text('Login with facebook'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: RaisedButton(
              onPressed: () => doLogout(),
              child: Text('LoOUT Google'),
            ),
          ),
          SizedBox(height: 20,),

        ],
      ),
    );
  }

  Widget _input(String hint, TextEditingController controller, bool obscure) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black38),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 3)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1)
          ),
        ),
      ),
    );
  }

  Widget button(String label, void func()) {
    return RaisedButton(
      splashColor: Colors.grey,
      highlightColor: Colors.lightBlue,
      child: Text(label,
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        func();
      },
    );
  }

  void _buttonAction() {
    _email = _emailController.text;
    _password = _passwordController.text;

    _emailController.clear();
    _passwordController.clear();
  }

  void doLogin() async {
    //showLoading();
    await _googleSignIn.signIn();
    initLogin();
  }

  void doLogout() async {
    //showLoading();
      await _googleSignIn.signOut();
      await facebookLogin.logOut();
  }


  initLogin() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async {
      if (account != null) {
        print ('Account enabled with hashCode: $account.hashCode');
        // user logged
      } else {
        print ('Account disabled');
        // user NOT logged
      }
    });
    _googleSignIn.signInSilently().whenComplete(() => dismissLoading());
  }

  dismissLoading() {
    String uName = _googleSignIn.currentUser.displayName.toString();
    String uHCode = _googleSignIn.currentUser.hashCode.toString();
    String uID = _googleSignIn.currentUser.id.toString();

    print ('Dismiss Loading Name: $uName');
    print ('Dismiss Loading hashCode: $uHCode');
    print ('Dismiss Loading uID: $uID');
  }

  void initiateFacebookLogin() async {
    var facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(["email"]);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("FBError");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("FBCancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("FBLoggedIn");
        final token = facebookLoginResult.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);

        onLoginStatusChanged(true);
        break;
    }
  }

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isFBLoggedIn = isLoggedIn;
    });
  }



}




