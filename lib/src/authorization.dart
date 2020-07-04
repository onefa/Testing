
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproarea/src/api_key.dart';
import 'package:flutterproarea/src/auth.dart';
import 'package:flutterproarea/src/pro_area_app.dart';
import 'package:flutterproarea/src/weather_base_item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:flutterproarea/src/w_styles.dart';

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
  TextEditingController _confirmPasswordController = TextEditingController();
  String _email;
  String _password;
  String _confirmPassword;
  bool showLogin = true;
  bool isFBLoggedIn = false;
  AuthService _authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WStyles.mainBackColor,
      body: Column(
        children: <Widget>[
          _logo(),
          (
          showLogin
              ? Column(
                children: <Widget>[
                  _form('Login', _loginButton),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Text('Not registered yet? Register',
                             style: WStyles.inputFieldTextStyle,),
                      onTap:() =>
                        setState(() {
                        showLogin = false;
                        }),
                    ),
                  )
                ],
                )
              : Column(
                children: <Widget>[
                  _form('Register', _registerButton),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Text('Already registered? Login',
                        style: WStyles.inputFieldTextStyle,),
                      onTap:() =>
                          setState(() {
                            showLogin = true;
                          }),
                    ),
                  )
                ],
                )
          ),
        ],
      ),

    persistentFooterButtons: <Widget>[
        RaisedButton (
          child: Text('Free', style: WStyles.buttonLightTextStyle,),
          color: WStyles.buttonBackColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          onPressed: () => _logOut(),
        ),
      SizedBox(width: 40,),
      FloatingActionButton.extended(
        label: Text('facebook', style: WStyles.buttonLightTextStyle,),
        onPressed: () => _loginFacebook(),
        ),
      FloatingActionButton.extended(
        label: Text('Google', style: WStyles.buttonLightTextStyle,),
        onPressed: () => _loginGoogle(),
      ),

      ],



    );
  }

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.only(top: 90),
      child: Container(
        child: Align(
          child: Text('WeatherBase',
          style: WStyles.titleTextStyle,
          ),
        ),
      ),
    );
  }

  Widget _form(String label, void func()) {
    return Container(
      child: Column(
        children:
        <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: _input(Icon(Icons.email), 'email', _emailController, false),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: _input(Icon(Icons.lock_outline),'password', _passwordController, true),
          ),
          (
          showLogin
          ? SizedBox(height: 2,)
          : Padding(
            padding: EdgeInsets.only(top: 10),
            child: _input(Icon(Icons.lock_outline),'confirm password', _confirmPasswordController, true),
            )
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: _button(label, func),
            ),
          ),
        ],
      ),

    );
  }

  Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: WStyles.inputFieldTextStyle,
        decoration: InputDecoration(
          hintStyle: WStyles.inputFieldHintTextStyle,
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderSide: WStyles.borderFocusSide
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: WStyles.borderEnabledSide
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: IconTheme(
              data: IconThemeData(color: WStyles.lightDecorColor),
              child: icon,
            ),
          )
        ),
      ),
    );
  }

  Widget _button(String label, void func()) {
    return RaisedButton(
      color: WStyles.buttonBackColor,
      splashColor: WStyles.buttonSplashColor,
      highlightColor: WStyles.buttonHighlightColor,
      child: Text(label,
        style: WStyles.buttonDarkTextStyle,
      ),
      onPressed: () {
        func();
      },
    );
  }

  _loginButton() async {
    _email = _emailController.text;
    _password = _passwordController.text;
    User user = await _authService.singInFirebase(_email, _password);
    if (user != null) {
      Fluttertoast.showToast(msg: 'Signed!', toastLength: Toast.LENGTH_SHORT);
      return ProAreaApp();
    }
    Fluttertoast.showToast(msg: "Can't sing in.");

  }

  _registerButton() async {
    _email = _emailController.text;
    _password = _passwordController.text;
    _confirmPassword = _confirmPasswordController.text;
    if (_confirmPassword != _password) {
        _confirmPasswordController.clear();
        _passwordController.clear();
        Fluttertoast.showToast(msg: 'Password not equal confirm string!');
        return;
    }
    User user = await _authService.registerInFirebase(_email, _password);
    if (user != null) {
      return ProAreaApp();
    }
    _emailController.clear();
    _confirmPasswordController.clear();
    _passwordController.clear();

    return;
  }

  void _loginGoogle() async {
    //showLoading();
    await _googleSignIn.signIn();
    _initLogin();
  }

  void _logOut() async {
    //showLoading();
      await _googleSignIn.signOut();
      await facebookLogin.logOut();
      await _authService.logOutFirebase();
  }


  void _initLogin() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async {
      if (account != null) {
        print ('Account enabled with hashCode: $account.hashCode');
        // user logged
      } else {
        print ('Account disabled');
        // user NOT logged
      }
    });
    _googleSignIn.signInSilently().whenComplete(() => _dismissLoading());
  }

  void _dismissLoading() {
    String uName = _googleSignIn.currentUser.displayName.toString();
    String uHCode = _googleSignIn.currentUser.hashCode.toString();
    String uID = _googleSignIn.currentUser.id.toString();

    print ('Dismiss Loading Name: $uName');
    print ('Dismiss Loading hashCode: $uHCode');
    print ('Dismiss Loading uID: $uID');
  }

  void _loginFacebook() async {
    var facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(["email"]);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("FBError");
        _onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("FBCancelledByUser");
        _onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("FBLoggedIn");
        final token = facebookLoginResult.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);

        _onLoginStatusChanged(true);
        break;
    }
  }

  void _onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isFBLoggedIn = isLoggedIn;
    });
  }



}




