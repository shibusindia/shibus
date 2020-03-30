import 'package:flutter/material.dart';

class EditChannel extends StatefulWidget {
  final String item;
  EditChannel(this.item);
  @override
  _EditChannelState createState() => _EditChannelState();
}

class _EditChannelState extends State<EditChannel> {
  final _formkey = GlobalKey<FormState>();
  List<String> _blacklistwords;
  final List<String> markets = ['ASK', 'BID'];
  String _currentMarket;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 0.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Edit ${widget.item} Channel',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.5),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Blacklist Words',
                    prefixIcon: Icon(
                      Icons.insert_link,
                      color: Colors.red,
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
                  validator: (val) =>
                      val.isEmpty ? 'Enter Blacklist Words' : null,
                  onChanged: (val) => setState(() {
                    _blacklistwords = val.split(',');
                    print(_blacklistwords);
                  }),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.5),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: Colors.green,
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
                  validator: (val) =>
                      val.isEmpty ? ' Enter the Spending Amount' : null,
                  onChanged: (val) => setState(() {
                    print(_blacklistwords);
                  }),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Buy @',
                          prefixIcon: Icon(
                            Icons.swap_vertical_circle,
                            color: Colors.green,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 0.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                        onChanged: (val) => setState(() {
                          print(_blacklistwords);
                        }),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Sell @',
                          prefixIcon: Icon(
                            Icons.swap_vertical_circle,
                            color: Colors.red,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 0.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                        onChanged: (val) => setState(() {
                          print(_blacklistwords);
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.5, horizontal: 0.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Stoploss',
                          prefixIcon: Icon(
                            Icons.trending_down,
                            color: Colors.red,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 0.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                        onChanged: (val) => setState(() {
                          print(_blacklistwords);
                        }),
                      ),
                    ),
                    Expanded(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(canvasColor: Colors.white),
                        child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'Market',
                              prefixIcon: Icon(
                                Icons.business_center,
                                color: Colors.green,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 0.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2.0),
                              ),
                            ),
                            value: _currentMarket ?? markets[0],
                            items: markets.map((market) {
                              return DropdownMenuItem(
                                value: market,
                                child: Text(
                                  '$market',
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                _currentMarket = val;
                              });
                            }),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'Trailing Configuration',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Take Profit',
                          prefixIcon: Icon(
                            Icons.timeline,
                            color: Colors.green,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 0.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                        onChanged: (val) => setState(() {
                          print(_blacklistwords);
                        }),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Trailing Stoploss',
                          prefixIcon: Icon(
                            Icons.trending_down,
                            color: Colors.red,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 1.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                        onChanged: (val) => setState(() {
                          print(_blacklistwords);
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Colors.black54,
                textColor: Colors.white,
                child: Text('Update'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                onPressed: () {},
              )
            ],
          ),
        ));
  }
}
