import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shibusindia/authenticate/authenticate.dart';
import 'package:shibusindia/model/user.dart';
import 'package:shibusindia/screen/home.dart';

class Wrapper extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {

    final user=Provider.of<User>(context);
    print(user);
    if(user==null){
      return Authenticate();
    }
    else{
      return HomePage();
    }
  }
}
