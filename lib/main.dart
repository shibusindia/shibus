import 'package:flutter/material.dart';
import 'package:shibusindia/screen/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:shibusindia/services/auth.dart';
import 'package:shibusindia/model/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Shibus',
        theme: ThemeData(canvasColor: Colors.transparent),
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
