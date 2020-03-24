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
  final bool isTelegramConnect;

  UserData(
      {this.uid,
      this.username,
      this.phonenumber,
      this.apikey,
      this.secretkey,
      this.isTelegramConnect});
}
