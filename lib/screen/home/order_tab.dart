import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shibusindia/model/history.dart';
import 'package:shibusindia/model/user.dart';
import 'package:shibusindia/services/database.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _items = List<String>.generate(4, (i) => 'item ${i + 1}');
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Container(
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
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '00.00',
                      style: TextStyle(
                        fontSize: 70.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    Icon(
                      Icons.attach_money,
                      size: 60,
                      color: Colors.white70,
                    ),
                  ],
                ),
                Text(
                  '0.000000000 BTC',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: StreamBuilder<List<History>>(
                stream: DatabaseService(uid: user.uid).getHistory,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Text(
                        'No history of trade available',
                        style: TextStyle(color: Colors.white, fontSize: 16.0,),
                      ),
                    );
                  }
                  List<History> queues = snapshot.data;
                  queues.forEach((history) {
                    print(history.signal);
                  });
                  return ListView.builder(
                    itemCount: _items.length ?? queues.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.grey.shade800,
                        ),
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width,
                        margin:
                            EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'LOOM/BTC' ?? queues[index].signal,
                                style: TextStyle(
                                  color: Colors.grey.shade200,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                'Quantity ${index ?? queues[index].quantity}'
                                    .toUpperCase(),
                                style: TextStyle(
                                  color: Colors.grey.shade200,
                                  fontSize: 12.0,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Buy @ ${0.061 ?? queues[index].buyAmount}'
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.grey.shade200,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'sell @ ${0.63 ?? queues[index].sellAmount}'
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.grey.shade200,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'profit ${2 ?? queues[index].profit}'
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.grey.shade200,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Status ${0 ?? queues[index].status}'
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.grey.shade200,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
