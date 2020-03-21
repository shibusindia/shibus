import 'package:flutter/material.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
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
        margin: EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'User Name'.toUpperCase(),
                    style: accountStyle(
                      size: 25.0,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Image(
                    image: AssetImage('assets/loginlogo.png'),
                    width: 65.0,
                    height: 65.0,
                  )
                ],
              ),
              Text(
                'Phone Number'.toUpperCase(),
                style: accountStyle(
                  size: 16.0,
                  weight: FontWeight.bold,
                ),
              ),
              Text(
                '+919747308327',
                style: accountStyle(size: 12.0),
              ),
              
              Text(
                'API Key'.toUpperCase(),
                style: accountStyle(
                  size: 16.0,
                  weight: FontWeight.bold,
                ),
              ),
              Text(
                                'abcdefghijklmnopqrstuvwxyz0123456789',
                style: accountStyle(size: 12.0),
              ),
              Text(
                'Secret Key'.toUpperCase(),
                style: accountStyle(
                  size: 16.0,
                  weight: FontWeight.bold,
                ),
              ),
              Text(
                'abcdefghijklmnopqrstuvwxyz0123456789',
                style: accountStyle(size: 12.0),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        tooltip: 'Edit',
        onPressed: () => showModalBottomSheet(
            context: context, builder: (ctx) => _buildBottomSheet(ctx)),
        child: Icon(
          Icons.edit,
          color: Colors.black,
          size: 25,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  TextStyle accountStyle({double size, FontWeight weight}) {
    return TextStyle(
      color: Colors.white,
      fontWeight: weight ?? FontWeight.normal,
      fontSize: size,
      letterSpacing: 2.0,
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
      child: Center(child: Text('botomSteet')),
    );
  }
}
