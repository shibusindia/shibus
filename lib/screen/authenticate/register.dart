import 'package:flutter/material.dart';
import 'package:shibusindia/animation/FadeAnimation.dart';
import 'package:shibusindia/services/auth.dart';

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
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _apikeyController = TextEditingController();
  final _secretkeyController = TextEditingController();
  bool _isEmailValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            errorText: _isEmailValid ? null : 'Incorrect Email',
                          ),
                          onChanged: (String value) {
                            if (!new RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              setState(() {
                                _isEmailValid = false;
                              });
                            } else {
                              setState(() {
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
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          labelText: 'Phone Number',
                          prefixText: '+91',
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                          errorText: isPhone ? null : 'Invalid Phone Number',
                        ),
                        onChanged: (String value) {
                          if (value.length != 10) {
                            setState(() {
                              isPhone = false;
                            });
                          } else {
                            setState(() {
                              isPhone = true;
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
                        controller: _passwordController,
                        obscureText: !this._showPassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: this._showPassword
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() =>
                                  this._showPassword = !this._showPassword);
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          errorText: _isPassword ? null : 'Incorrect Password',
                        ),
                        onChanged: (String value) {
                          if (value.length < 8 || value == '') {
                            setState(() {
                              this._isPassword = false;
                            });
                          } else {
                            setState(() {
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
                          ),
                          errorText: _isConfirm ? null : 'Password not matched',
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                            ),
                            onPressed: () {
                              setState(
                                  () => this._showConfirm = !this._showConfirm);
                            },
                          ),
                        ),
                        onChanged: (String value) {
                          if (_confirmPasswordController.text !=
                              _passwordController.text) {
                            setState(() {
                              this._isConfirm = false;
                            });
                          } else {
                            setState(() {
                              this._isConfirm = true;
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          labelText: 'Binance API Key',
                          prefixIcon: Icon(Icons.vpn_key),
                        ),
                        controller: _apikeyController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: _minpad * 3,
                        left: _minpad * 3,
                        right: _minpad * 3,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          labelText: 'Binance Secret Key',
                          prefixIcon: Icon(Icons.security),
                        ),
                        controller: _secretkeyController,
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
                            color: Colors.red,
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
                                    _passwordController.text.toString());
                                  
                                if (result == null) {
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Invalid Credential'),
                                  ));
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
                            textColor: Colors.red,
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
    );
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
            Text(
              'Shibus India'.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 27.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
