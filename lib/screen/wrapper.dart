import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shibusindia/screen/authenticate/authenticate.dart';
import 'package:shibusindia/model/user.dart';
import 'package:shibusindia/screen/home/home.dart';

class Wrapper extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {

    final user=Provider.of<User>(context);
    if(user==null){
      return Authenticate();
    }
    else{
      return HomePage();
    }
  }
}
