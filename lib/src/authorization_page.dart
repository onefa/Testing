import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproarea/src/api_key.dart';
import 'package:flutterproarea/src/authorization_service.dart';
import 'package:flutterproarea/src/weather_base_item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutterproarea/src/w_styles.dart';


class AutorizationPage extends StatefulWidget {
  AutorizationPage({Key key}) : super (key: key);

  @override
  _AutorizationPageState createState() => _AutorizationPageState();
}

class _AutorizationPageState extends State<AutorizationPage> {

  @override
  void initState () {
    super.initState();
  }


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String _email;
  String _password;
  String _confirmPassword;
  bool showLogin = true;
  //bool isFBLoggedIn = false;
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
        onPressed: () => _signFree(),
      ),
      SizedBox(width: 40,),
      FloatingActionButton.extended(
        heroTag: Text(''),
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

  bool isEmail(String email) {
    String emailRegexp =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(emailRegexp);

    return regExp.hasMatch(email);
  }

  _infoToast(String info) {
    Fluttertoast.showToast(msg: info,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: WStyles.toastInfoBackgroundColor,
        textColor: WStyles.toastInfoTextColor,
        fontSize: WStyles.toastInfoFontSize);
  }

  _alarmToast(String alarm) {
    Fluttertoast.showToast(msg: alarm,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: WStyles.toastAlarmBackgroundColor,
        textColor: WStyles.toastAlarmTextColor,
        fontSize: WStyles.toastAlarmFontSize);
  }

  _loginButton() async {
    _email = _emailController.text;
    _password = _passwordController.text;
    if (!isEmail(_email)) {
      _alarmToast('Invalid email!');
      return;
    }
    User user = await _authService.singInFirebase(_email, _password);
    if (user != null) {
      _infoToast('Signed Firebase!');
    _emailController.clear();
    _passwordController.clear();
    } else {
      _alarmToast("Can't sing in Firebase :(");
    }

  }

  _registerButton() async {
    _email = _emailController.text;
    _password = _passwordController.text;
    _confirmPassword = _confirmPasswordController.text;

    if (!isEmail(_email)) {
      _alarmToast('Invalid email!');
      return;
    }
    if (_confirmPassword != _password) {
        _confirmPasswordController.clear();
        _passwordController.clear();
        _alarmToast('Password not equal confirm string!');
        return;
    }
    User user = await _authService.registerInFirebase(_email, _password);
    if (user != null) {
      _infoToast('Registered Firebase!');
      _emailController.clear();
      _confirmPasswordController.clear();
      _passwordController.clear();
    } else {
      _alarmToast("Can't register. Check email/password");
    }
  }

  _loginGoogle() async {

    User user = await _authService.loginGoogle();
    if (user != null) {
      _infoToast('Signed Google!');
    } else {
      _alarmToast("Can't sing in Google:(");
    }
  }

  _loginFacebook() async {

    User user = await _authService.loginFacebook();
    if (user != null) {
      _infoToast('Signed Facebook!');
    } else {
      _alarmToast("Can't sing in Facebook:(");
    }
  }

  _signFree() async {
    User user = await _authService.singInFirebase(ApiKey().emailFreeUser, ApiKey().passwordFreeUser);

    if (user != null) {
      _infoToast('Signed free!');
    } else {
      _alarmToast("Can't sing in :(");
    }

  }

}




