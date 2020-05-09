import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shibusindia/model/channel.dart';
import 'package:shibusindia/model/user.dart';
import 'package:shibusindia/services/database.dart';

class EditChannel extends StatefulWidget {
  final ChannelsData channel;
  EditChannel({this.channel});
  @override
  _EditChannelState createState() => _EditChannelState();
}

class _EditChannelState extends State<EditChannel> {
  final _formkey = GlobalKey<FormState>();
  String _blacklistwords;
  double _quantity;
  double _buyAt;
  double _sellAt;
  double _trailingStoploss;
  double _stoploss;
  double _takeprofit;
  String _currentMarket;
  final List<String> markets = ['ASK', 'BID'];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
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
                'Edit ${widget.channel.name} Channel',
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
                  initialValue:
                      widget.channel.blacklistWords.toLowerCase() ?? _blacklistwords,
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
                    _blacklistwords = val.toLowerCase();
                  }),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.5),
                child: TextFormField(
                  initialValue:
                      widget.channel.amount.toString() ?? _quantity.toString(),
                  keyboardType: TextInputType.number,
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
                    _quantity = double.parse(val);
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
                        initialValue: widget.channel.buyPercent.toString() ??
                            _buyAt.toString(),
                        keyboardType: TextInputType.number,
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
                          _buyAt = double.parse(val);
                        }),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: widget.channel.sellPercent.toString() ??
                            _sellAt.toString(),
                        keyboardType: TextInputType.number,
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
                          _sellAt = double.parse(val);
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
                        initialValue: widget.channel.stoploss.toString() ??
                            _stoploss.toString(),
                        keyboardType: TextInputType.number,
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
                          _stoploss = double.parse(val);
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
                            value: _currentMarket ?? widget.channel.market,
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
                        initialValue: widget.channel.takeProfit.toString() ??
                            _takeprofit.toString(),
                        keyboardType: TextInputType.number,
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
                          _takeprofit = double.parse(val);
                        }),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue:
                            widget.channel.trailingStoploss.toString() ??
                                _trailingStoploss.toString(),
                        keyboardType: TextInputType.number,
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
                          _trailingStoploss = double.parse(val);
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
                  onPressed: () async {
                    await DatabaseService(uid: user.uid)
                        .updateChannel(
                      channelId: widget.channel.channelId,
                      name: widget.channel.name,
                      blacklistWords:
                          _blacklistwords ?? widget.channel.blacklistWords,
                      stoploss: _stoploss ?? widget.channel.stoploss,
                      market: _currentMarket ?? widget.channel.market,
                      sellPercent: _sellAt ?? widget.channel.sellPercent,
                      buyPercent: _buyAt ?? widget.channel.buyPercent,
                      takeProfit: _takeprofit ?? widget.channel.takeProfit,
                      trailingstoploss:
                          _trailingStoploss ?? widget.channel.trailingStoploss,
                      quantity: _quantity ?? widget.channel.amount,
                    );
                      

                    Navigator.pop(context);
                  })
            ],
          ),
        ));
  }
}
