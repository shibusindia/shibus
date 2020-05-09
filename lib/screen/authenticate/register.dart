import 'package:flutter/material.dart';
import 'package:shibusindia/animation/FadeAnimation.dart';
import 'package:shibusindia/screen/loading.dart';
import 'package:shibusindia/services/auth.dart';
import 'package:shimmer/shimmer.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;
  RegisterPage({this.toggleView});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthService _auth = AuthService();
  final _minpad = 5.0;
  bool isPhone = true;
  bool loading = false;
  bool _showPassword = false;
  bool _showConfirm = false;
  bool _isPassword = true;
  bool _isConfirm = true;
  Color _passColor = Colors.grey;
  Color _emailColor = Colors.grey;
  Color _confirmColor = Colors.grey;
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isEmailValid = true;

  @override
  void dispose() {
    _emailController.dispose();
    _confirmPasswordController.dispose();
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
                  color: Colors.black54,
                ),
                child: ListView(
                  children: <Widget>[
                    getImageAsset(),
                    FadeAnimation(
                      1.5,
                      Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                        ),
                        margin: EdgeInsets.only(
                          left: _minpad * 2,
                          right: _minpad * 2,
                          top: _minpad * 7,
                          bottom: _minpad * 4,
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top: _minpad * 3,
                                left: _minpad * 3,
                                right: _minpad * 3,
                              ),
                              child: TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(
                                      Icons.mail_outline,
                                      color: _emailColor,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    errorText: _isEmailValid
                                        ? null
                                        : 'Incorrect Email',
                                  ),
                                  onChanged: (String value) {
                                    if (!new RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                      setState(() {
                                        _isEmailValid = false;
                                        _emailColor = Colors.redAccent;
                                      });
                                    } else {
                                      setState(() {
                                        _emailColor = Colors.blueAccent;
                                        _isEmailValid = true;
                                      });
                                    }
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: _minpad * 3,
                                left: _minpad * 3,
                                right: _minpad * 3,
                              ),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: !this._showPassword,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: _passColor,
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
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  errorText:
                                      _isPassword ? null : 'Incorrect Password',
                                ),
                                onChanged: (String value) {
                                  if (value.length < 8 || value == '') {
                                    setState(() {
                                      _passColor = Colors.red;
                                      this._isPassword = false;
                                    });
                                  } else {
                                    setState(() {
                                      _passColor = Colors.blue;
                                      this._isPassword = true;
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
                                obscureText: !this._showConfirm,
                                controller: _confirmPasswordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  labelText: 'Confirm Password',
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: _confirmColor,
                                  ),
                                  errorText: _isConfirm
                                      ? null
                                      : 'Password not matched',
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.remove_red_eye,
                                        color: this._showConfirm
                                            ? Colors.blue
                                            : Colors.grey),
                                    onPressed: () {
                                      setState(() => this._showConfirm =
                                          !this._showConfirm);
                                    },
                                  ),
                                ),
                                onChanged: (String value) {
                                  if (_confirmPasswordController.text !=
                                      _passwordController.text) {
                                    setState(() {
                                      _confirmColor = Colors.redAccent;
                                      this._isConfirm = false;
                                    });
                                  } else {
                                    setState(() {
                                      _confirmColor = Colors.blueAccent;
                                      this._isConfirm = true;
                                    });
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: _minpad,
                                bottom: _minpad * 2,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RaisedButton(
                                    child: Text(
                                      'Register'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    splashColor: Colors.white30,
                                    color: Colors.black54,
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    onPressed: () async {
                                      if (_isPassword && _isEmailValid) {
                                        setState(() {
                                          loading = true;
                                        });
                                        dynamic result = await _auth.register(
                                            _emailController.text.toString(),
                                            _passwordController.text
                                                .toString());
                                        if (result == null) {
                                          setState(() {
                                            loading = false;
                                          });
                                        }
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: _minpad * 3,
                                  ),
                                  RaisedButton(
                                    splashColor: Colors.white30,
                                    child: Text(
                                      'Login'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    textColor: Colors.black54,
                                    color: Colors.white,
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
              highlightColor: Colors.black12,
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
