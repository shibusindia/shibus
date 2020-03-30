import 'package:flutter/material.dart';
import 'package:shibusindia/screen/home/account_tab.dart';
import 'package:shibusindia/screen/home/order_tab.dart';
import 'package:shibusindia/screen/home/settings_tab.dart';
import 'package:shibusindia/screen/home/telegram_tab.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabPages = <Widget>[
      Telegram(),
      Accounts(),
      Orders(),
      Settings(),
    ];
    final bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        title: Text(
          'Home',
          style: TextStyle(),
        ),
        activeIcon: Icon(
          Icons.home,
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
        ),
        title: Text(
          'Account',
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.credit_card),
        title: Text('Orders'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        title: Text('Settings'),
      ),
    ];
    assert(tabPages.length == bottomNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      items: bottomNavBarItems,
      elevation: 10.0,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.white,
      selectedItemColor: Color(0xff00d2ff),
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Shibus'.toUpperCase()),
        actions: <Widget>[
          IconButton(
            onPressed: () => print('on /off pressed'),
            icon: Icon(Icons.power_settings_new),
            tooltip: 'Cloud On/Off',
          ),
        ],
      ),
      body: tabPages[_currentIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}
