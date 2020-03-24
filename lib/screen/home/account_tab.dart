import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shibusindia/model/user.dart';
import 'package:shibusindia/screen/bottomSheet/account_bottom.dart';
import 'package:shibusindia/screen/loading.dart';
import 'package:shibusindia/services/database.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _pin;
  bool _approved=false;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userdata,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Loader();
          }
          UserData configData = snapshot.data;
          return Scaffold(
            key: _scaffoldKey,
            body: Container(
              height: MediaQuery.of(context).size.height / 2.6,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  colors: [
                    Color(0xff00d2ff),
                    Color(0xff3a7bd5),
                  ],
                ),
              ),
              margin: EdgeInsets.all(5.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          configData.username.toUpperCase(),
                          style: accountStyle(
                            size: 25.0,
                            weight: FontWeight.bold,
                          ),
                        ),
                        Image(
                          image: AssetImage('assets/loginlogo.png'),
                          width: 65.0,
                          height: 65.0,
                        )
                      ],
                    ),
                    Text(
                      'Phone Number'.toUpperCase(),
                      style: accountStyle(
                        size: 16.0,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '+91${configData.phonenumber}',
                          style: accountStyle(size: 12.0),
                        ),
                        Icon(
                          Icons.check_circle_outline,
                          color:_approved? Colors.greenAccent:Colors.black54,
                        ),
                        GestureDetector(
                          child: Text(
                            'Connect  Telegram'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                decoration: TextDecoration.underline),
                          ),
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Enter you Telegram Pin'),
                                content: Form(
                                  key: _formkey,
                                  child: TextFormField(
                                    
                      
                                    decoration: InputDecoration(
                                      labelText: 'Telegram Pin',
                                      prefixIcon: Icon(
                                        Icons.vpn_key,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 0.0, vertical: 0.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2.0),
                                      ),
                                    ),
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter the Pin' : null,
                                    onChanged: (val) =>
                                        setState(() => _pin = val),
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      if (_formkey.currentState.validate()) {
                                        setState(() {
                                          _approved=true;
                                        });
                                        Navigator.pop(context, _pin);
                                        
                                      }
                                    },
                                    child: Text('Confirm'),
                                  ),
                                ],
                              ),
                            ).then((onValue) {
                              if (onValue != null) {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Connected'),
                                    action: SnackBarAction(
                                      label: 'OK',
                                      onPressed: () {
                                        
                                      },
                                    ),
                                  ),
                                );
                              }
                            });
                          },
                        )
                      ],
                    ),
                    Text(
                      'API Key'.toUpperCase(),
                      style: accountStyle(
                        size: 16.0,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      configData.apikey,
                      style: accountStyle(size: 12.0),
                    ),
                    Text(
                      'Secret Key'.toUpperCase(),
                      style: accountStyle(
                        size: 16.0,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      configData.secretkey,
                      style: accountStyle(size: 12.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        RaisedButton(
                          shape: CircleBorder(),
                          color: Colors.black45,
                          elevation: 5.0,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20.0,
                          ),
                          onPressed: () => print('binance conect'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              tooltip: 'Edit',
              onPressed: () => showModalBottomSheet(
                  context: context, builder: (ctx) => _buildBottomSheet(ctx)),
              child: Icon(
                Icons.edit,
                color: Colors.black,
                size: 25,
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        });
  }

  TextStyle accountStyle({double size, FontWeight weight}) {
    return TextStyle(
      color: Colors.white,
      fontWeight: weight ?? FontWeight.normal,
      fontSize: size,
      letterSpacing: 2.0,
    );
  }

  _buildBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: AccountBottom(),
    );
  }
}
