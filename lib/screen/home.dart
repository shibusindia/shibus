import 'package:flutter/material.dart';
import 'package:shibusindia/services/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        
        child: RaisedButton(onPressed: (){
          _auth.signOut();
        }
        ,child: Text('signOut'),),
      ),
    );
  }
}
