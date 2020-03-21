import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Telegram extends StatefulWidget {
  @override
  _TelegramState createState() => _TelegramState();
}

class _TelegramState extends State<Telegram> {
  final _items = List<String>.generate(6, (i) => 'item ${i + 1}');
  bool _switchVal = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final String item = _items[index];
          return Dismissible(
            key: Key(item),
            onDismissed: (DismissDirection direction) {
              setState(() {
                this._items.removeAt(index);
              });
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Channel Removed'),
                  action: SnackBarAction(label:'UNDO' 
                  , onPressed: (){
                    setState(() {
                      this._items.insert(index, item);
                    });
                  }),
                ),
              );
            },
            child: Card(
              color: Colors.grey.shade800,
              margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
              elevation: 5.0,
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
                        Text(
                          'Signal',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey.shade100,
                            backgroundColor: Colors.blueAccent,
                            height: 2.0,
                          ),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                'Stoloss',
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
          );
        },
      ),
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
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
      ),
      child: Center(child: Text('Add Channel')),
    );
  }
}
