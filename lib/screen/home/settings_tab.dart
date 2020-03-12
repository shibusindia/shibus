import 'package:flutter/material.dart';
import 'package:shibusindia/services/auth.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: RawMaterialButton(fillColor: Colors.white,
        onPressed: () => _auth.signOut(),
        child: Text('Sign Out'),
      ),
    ));
  }
}
