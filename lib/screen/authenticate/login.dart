import 'package:flutter/material.dart';
import 'package:shibusindia/animation/FadeAnimation.dart';
import 'package:shibusindia/screen/loading.dart';
import 'package:shibusindia/services/auth.dart';
import 'package:shimmer/shimmer.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  LoginPage({this.toggleView});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService _auth = AuthService();
  bool loading = false;
  bool _isEmailValid = true;
  bool isPasswordValid = true;
  bool _showPassword = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _minpad = 5.0;
  Color _iconColor = Colors.grey;
  Color _iconemail = Colors.grey;
  String email = "";
  String password = "";
  bool isLoggedIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loader()
        : Scaffold(
            body: Builder(
              builder: (context) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      Color(0xff20639b),
                      Color(0xff3caea3),
                    ],
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    getImageAsset(),
                    FadeAnimation(
                      1.5,
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                        ),
                        margin: EdgeInsets.only(
                          left: _minpad * 2,
                          right: _minpad * 2,
                          top: _minpad * 7,
                        ),
                        elevation: 10.0,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(_minpad * 3),
                              child: TextField(
                                controller: _emailController,
                                cursorColor: _iconColor,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(
                                    Icons.mail_outline,
                                    color: _iconemail,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  errorText: _isEmailValid
                                      ? null
                                      : 'Please Enter Email',
                                ),
                                onChanged: (String value) {
                                  if (!new RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    setState(() {
                                      _isEmailValid = false;
                                      _iconemail = Colors.red;
                                    });
                                  } else {
                                    setState(() {
                                      _isEmailValid = true;
                                      _iconemail = Colors.blue;
                                    });
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: _minpad * 3,
                                left: _minpad * 3,
                                right: _minpad * 3,
                              ),
                              child: TextField(
                                obscureText: !this._showPassword,
                                controller: _passwordController,
                                cursorColor: _iconColor,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: _iconColor,
                                  ),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: this._showPassword
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() => this._showPassword =
                                            !this._showPassword);
                                      }),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  errorText: isPasswordValid
                                      ? null
                                      : 'Please Enter Password',
                                ),
                                onChanged: (String value) {
                                  if (value.length < 8 || value == '') {
                                    setState(() {
                                      _iconColor = Colors.red;
                                      this.isPasswordValid = false;
                                    });
                                  } else {
                                    setState(() {
                                      _iconColor = Colors.blue;
                                      this.isPasswordValid = true;
                                    });
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: _minpad * 4,
                                bottom: _minpad * 4,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RaisedButton(
                                    splashColor: Colors.white30,
                                    child: Text(
                                      'Login'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    onPressed: () async {
                                      if (this._isEmailValid &&
                                          this.isPasswordValid) {
                                        setState(() {
                                          loading = true;
                                        });
                                        dynamic result = await _auth.login(
                                            _emailController.text.toString(),
                                            _passwordController.text
                                                .toString());

                                        if (result == null) {
                                          setState(() {
                                            loading = false;
                                          });
                                          displaySnackBar(context);
                                        }
                                      } else {
                                        displaySnackBar(context);
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: _minpad * 3,
                                  ),
                                  RaisedButton(
                                    child: Text(
                                      'Register'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    splashColor: Colors.white30,
                                    color: Colors.white,
                                    textColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    onPressed: () {
                                      widget.toggleView();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  displaySnackBar(BuildContext context) {
    final snackbar = SnackBar(
      content: Text('Invalid Credentials'),
      action: SnackBarAction(
          label: 'Ok', onPressed: Scaffold.of(context).hideCurrentSnackBar),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('assets/loginlogo.png');
    Image image = Image(
      image: assetImage,
      width: 120.0,
      height: 120.0,
    );
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          image,
          FadeAnimation(
            1.2,
            Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Color(0xff3caea3),
              child: Text(
                'Shibus India'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 27.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
