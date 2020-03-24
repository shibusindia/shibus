import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shibusindia/model/user.dart';
import 'package:shibusindia/screen/loading.dart';
import 'package:shibusindia/services/database.dart';

class AccountBottom extends StatefulWidget {
  @override
  _AccountBottomState createState() => _AccountBottomState();
}

class _AccountBottomState extends State<AccountBottom> {
  final _key = GlobalKey<FormState>();
  String _currentUsername;
  String _currentApikey;
  String _currentSecretkey;
  String _currentPhoneNumber;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userdata,
        builder: (context, snapshot) {
          UserData configData = snapshot.data;
          if (snapshot.data == null) {
            return Loader();
          }
          if (snapshot.hasData) {
            return Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Update your Configuration Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                  TextFormField(
                    initialValue: configData.username,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(
                        Icons.person_outline,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                    validator: (val) => val.isEmpty ? 'Enter Username' : null,
                    onChanged: (val) => setState(() => _currentUsername = val),
                  ),
                  TextFormField(
                    initialValue: configData.phonenumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      prefixText: '+91',
                      prefixIcon: Icon(
                        Icons.phone,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                    validator: (val) => val.isEmpty || val.length < 10
                        ? 'Enter Correct Phone Number'
                        : null,
                    onChanged: (val) =>
                        setState(() => _currentPhoneNumber = val),
                  ),
                  TextFormField(
                    initialValue: configData.apikey,
                    decoration: InputDecoration(
                      labelText: 'API Key',
                      prefixIcon: Icon(Icons.security),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Enter the API key' : null,
                    onChanged: (val) => setState(() => _currentApikey = val),
                  ),
                  TextFormField(
                    initialValue: configData.secretkey,
                    decoration: InputDecoration(
                      labelText: 'Secret Key',
                      prefixIcon: Icon(
                        Icons.vpn_key,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                    validator: (val) => val.isEmpty ? 'Enter Secret Key' : null,
                    onChanged: (val) => setState(() => _currentSecretkey = val),
                  ),
                  RaisedButton(
                    color: Colors.black54,
                    textColor: Colors.white,
                    child: Text('Update'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    onPressed: () async {
                      if (_key.currentState.validate()) {
                        await DatabaseService(uid: user.uid).configData(
                          apikey: _currentApikey ?? configData.apikey,
                          secretkey: _currentSecretkey ?? configData.secretkey,
                          username: _currentUsername ?? configData.username,
                          phone: _currentPhoneNumber ?? configData.phonenumber,
                        );
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return Loader();
          }
        });
  }
}
