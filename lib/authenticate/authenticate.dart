import 'package:flutter/material.dart';
import 'package:shibusindia/authenticate/login.dart';
import 'package:shibusindia/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginPage(toggleView: toggleView);
    } else {
      return RegisterPage(toggleView: toggleView);
    }
  }
}

// class Authenticate extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LoginPage();
//   }
// }
