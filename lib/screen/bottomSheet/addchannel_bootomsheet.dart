import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:shibusindia/model/user.dart';
import 'package:shibusindia/services/database.dart';

class AddChannel extends StatefulWidget {
  @override
  _AddChannelState createState() => _AddChannelState();
}

class _AddChannelState extends State<AddChannel> {
  final _formkey = GlobalKey<FormState>();
  String _channelName;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Form(
        key: _formkey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Add Your Favourite Telegram Channels',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Channel Name',
                  prefixIcon: Transform.rotate(
                    angle: 315 * math.pi / 180,
                    child: Icon(
                      Icons.send,
                    ),
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
                validator: (val) => val.isEmpty ? 'Enter Channel Name' : null,
                onChanged: (val) =>
                    setState(() => _channelName = val.replaceAll(' ', '')),
              ),
            ),
            RaisedButton(
              color: Colors.black54,
              textColor: Colors.white,
              child: Text('Add Channel'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              onPressed: () async {
                if (_formkey.currentState.validate()) {
                  await DatabaseService(uid: user.uid)
                      .addChannel(
                        name: _channelName,
                        blacklistword: 'ACHIEVED,TARGET ACHIEVED,SUCESSS',
                        buypercent: 0.0,
                        isstoploss: false,
                        istrailing: false,
                        market: 'ASK',
                        takeprofit: 1.0,
                        trailingstoploss: 1.0,
                        stoploss: 3.0,
                        quantity: 0.0012,
                        profile: '',
                        sellpercent: 2.0,
                        signal: '',
                      )
                      .catchError((error) => print(error));
                  Navigator.pop(context);
                }
              },
            )
          ],
        ));
  }
}
