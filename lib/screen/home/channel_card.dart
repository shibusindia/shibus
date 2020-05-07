import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shibusindia/model/channel.dart';
import 'package:shibusindia/screen/bottomSheet/channel_bottom.dart';

class ChannelCard extends StatefulWidget {
  @override
  _ChannelCardState createState() => _ChannelCardState();
  final ChannelsData channel;
  ChannelCard({this.channel});
}

class _ChannelCardState extends State<ChannelCard> {
  bool _switchVal = false;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: Key(widget.channel.name),
      onDismissed: (DismissDirection direction) {
        setState(() {});
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Channel Removed'),
            action: SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  setState(() {});
                }),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            colors: [
              Color(0xff00d2ff),
              Color(0xff3a7bd5),
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: Image(image: AssetImage('assets/loginlogo.png')),
                backgroundColor: Colors.transparent,
                radius: 40.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Channel Name',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey.shade200,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Signal',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                          height: 2.0,
                        ),
                      ),
                      FlatButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) => _channelBottomSheet(ctx),
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Edit Channel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Text(
                          'Trailing',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      CupertinoSwitch(
                          activeColor: Colors.grey.shade100,
                          value: _switchVal,
                          onChanged: (value) {
                            setState(() {
                              _switchVal = value;
                            });
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'Stoploss',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      CupertinoSwitch(
                          activeColor: Colors.grey.shade100,
                          value: _switchVal,
                          onChanged: (value) {
                            setState(() {
                              _switchVal = value;
                            });
                          }),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      background: Container(
        decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            )),
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.delete,
              size: 35.0,
              color: Colors.white,
            ),
            Text(
              'Delete Channel',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  _channelBottomSheet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: EditChannel(widget.channel),
    );
  }
}
