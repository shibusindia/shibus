import 'package:flutter/material.dart';
import 'dart:math' as math;

class AddChannel extends StatefulWidget {
  @override
  _AddChannelState createState() => _AddChannelState();
}

class _AddChannelState extends State<AddChannel> {
  final _formkey = GlobalKey<FormState>();
  String _channelName;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
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
                  print(_channelName);
                  Navigator.pop(context);
                }
              },
            )
          ],
        ));
  }
}
