import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shibusindia/model/channel.dart';
import 'package:shibusindia/model/user.dart';
import 'package:shibusindia/screen/bottomSheet/addchannel_bootomsheet.dart';
import 'package:shibusindia/screen/bottomSheet/channel_bottom.dart';
import 'package:shibusindia/screen/loading.dart';
import 'package:shibusindia/services/database.dart';

class Telegram extends StatefulWidget {
  @override
  _TelegramState createState() => _TelegramState();
}

class _TelegramState extends State<Telegram> {
  bool _isTrailing = false;
  bool _isStoploss = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      body: StreamBuilder<List<ChannelsData>>(
          stream: DatabaseService(uid: user.uid).getChannel,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Loader();
            }
            List<ChannelsData> channels = snapshot.data;
            return ListView.builder(
                itemCount: channels.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    direction: DismissDirection.startToEnd,
                    key: Key(channels[index].channelId),
                    onDismissed: (DismissDirection direction) async {
                      ChannelsData recent = channels[index];
                      await DatabaseService(uid: user.uid)
                          .deleteChannel(channelId: channels[index].channelId)
                          .then((value) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Channel Removed'),
                            action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () async {
                                  await DatabaseService(uid: user.uid)
                                      .addChannel(
                                    blacklistword: recent.blacklistWords,
                                    signal: recent.signal,
                                    buypercent: recent.buyPercent,
                                    sellpercent: recent.sellPercent,
                                    isstoploss: recent.isStoploss,
                                    istrailing: recent.isTrailing,
                                    market: recent.market,
                                    name: recent.name,
                                    profile: recent.profileImage,
                                    quantity: recent.amount,
                                    stoploss: recent.stoploss,
                                    trailingstoploss: recent.trailingStoploss,
                                    takeprofit: recent.takeProfit,
                                  )
                                      .then((val) {
                                    recent = null;
                                  });
                                }),
                          ),
                        );
                      });
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
                              child: Image(
                                  image: AssetImage('assets/loginlogo.png')),
                              backgroundColor: Colors.transparent,
                              radius: 40.0,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    channels[index].name.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.grey.shade200,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      channels[index].signal ?? '',
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
                                          builder: (ctx) => _channelBottomSheet(
                                              ctx, channels[index]),
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
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
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
                                        value: channels[index].isTrailing,
                                        onChanged: (value) async {
                                          setState(() {
                                            _isTrailing = value;
                                          });
                                          await DatabaseService(uid: user.uid)
                                              .updateStoploss(
                                            channelId:
                                                channels[index].channelId,
                                            isTrailing: value,
                                            isStoploss: _isStoploss,
                                          );
                                        }),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
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
                                        value: channels[index].isStoploss,
                                        onChanged: (value) async {
                                          setState(() {
                                            _isStoploss = value;
                                          });
                                          await DatabaseService(uid: user.uid)
                                              .updateStoploss(
                                            channelId:
                                                channels[index].channelId,
                                            isTrailing: _isTrailing,
                                            isStoploss: value,
                                          );
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
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        tooltip: 'Add Channel',
        onPressed: () => showModalBottomSheet(
            context: context, builder: (ctx) => _buildBottomSheet(ctx)),
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 25,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _buildBottomSheet(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: AddChannel(),
    );
  }

  _channelBottomSheet(BuildContext context, ChannelsData channel) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: EditChannel(channel: channel),
    );
  }
}
