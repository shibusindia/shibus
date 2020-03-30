import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _items = List<String>.generate(10, (i) => 'item ${i + 1}');
  @override
  Widget build(BuildContext context) {
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
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey.shade800,
                  margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                  elevation: 5.0,
                  child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('$index'),
                    )
                  ]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
