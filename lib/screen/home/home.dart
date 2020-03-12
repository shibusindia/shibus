import 'package:flutter/material.dart';
import 'package:shibusindia/services/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabPages = <Widget>[
      Center(
        child: Icon(
          Icons.home,
          size: 64.0,
          color: Colors.redAccent,
        ),
      ),
      Center(
        child: Icon(
          Icons.home,
          size: 64.0,
          color: Colors.redAccent,
        ),
      ),
      Center(
        child: Icon(
          Icons.home,
          size: 64.0,
          color: Colors.redAccent,
        ),
      ),
      Center(
        child: FlatButton.icon(
          onPressed: () => _auth.signOut(),
          icon: Icon(Icons.all_out),
          label: Text('signout'),
        ),
      ),
    ];
    final bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.send),
        title: Text('home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_balance_wallet),
        title: Text('home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        title: Text('Settings'),
      ),
    ];
    assert(tabPages.length == bottomNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      items: bottomNavBarItems,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          print(_currentIndex);
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Shibus'.toUpperCase()),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () => print('help button pressed'),
            icon: Icon(Icons.help_outline),
            label: Text('Help'),
          ),
          FlatButton.icon(
            onPressed: () => print('on /off pressed'),
            icon: Icon(Icons.power_settings_new),
            label: Text('on/off'),
          ),
        ],
      ),
      body: tabPages[_currentIndex],
      bottomNavigationBar: bottomNavBar,
    );

    //Container(
    //   child: Center(
    //     child: RaisedButton(
    //       onPressed: () {
    //         _auth.signOut();
    //       },
    //       child: Text('signOut'),
    //     ),
    //   ),
    // );
  }
}
