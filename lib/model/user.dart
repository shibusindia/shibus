// import 'package:shibusindia/model/channel.dart';

class User {
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final String username;
  final String phonenumber;
  final String apikey;
  final String secretkey;
  final bool iscloud;

  UserData({
    this.uid,
    this.username,
    this.phonenumber,
    this.apikey,
    this.secretkey,
    this.iscloud
  });
}
