import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shibusindia/model/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userConfig =
      Firestore.instance.collection('clients');
  // final CollectionReference channel = Firestore.instance.collection('Channel');

  // Future updateChannelSetting({
  //   String type, //private or public
  //   String market, // Ask or BId
  //   String name, //channel name
  //   String profileImage, // telegram display picture
  //   double buyPercent, // buy at percentage
  //   double sellPercent, //sell percentage
  //   bool isTrailing, // trailing on or off
  //   bool isStoploss, //stoploss on or off
  //   double takeProfit, // take profit associated with trailing
  //   double
  //       trailingStoploss, // stoploss in traling, activate aftertake profit achieved.
  //   double stoploss, //Stoploss
  //   String signal, // recent signal shown in telegram Channel
  //   String uid,
  // }) async {
  //   return await channel.document(uid).setData({
  //     'uid': uid,
  //     'type': type,
  //     'market': market,
  //     'name': name,
  //     'profileImage': profileImage,
  //     'buyAtPercent': buyPercent,
  //     'sellAtPetcent': sellPercent,
  //     'isTrailing': isTrailing,
  //     'isStoploss': isStoploss,
  //     'takeProfit': takeProfit,
  //     'trailingStoploss': trailingStoploss,
  //     'stoploss': stoploss,
  //     'signal': signal,
  //   });
  // }

  Future configData({
    String username,
    String phone,
    String apikey,
    String secretkey,
  }) async {
    return await userConfig.document(uid).setData({
      'username': username,
      'apikey': apikey,
      'secretkey': secretkey,
      'phonenumber': phone
    });
  }

  // Config _configSnapshot(DocumentSnapshot snapshot) {
  //   return Config(
  //     apikey: snapshot.data['apikey'] ,
  //     username: snapshot.data['username'] ,
  //     phonenumber: snapshot.data['phonenumber'] ,
  //     secretkey: snapshot.data['seceretkey'],
  //   );
  // }

  UserData _userDatasnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        username: snapshot.data['username'],
        apikey: snapshot.data['apikey'],
        secretkey: snapshot.data['secretkey'],
        phonenumber: snapshot.data['phonenumber']);
  }

  // streaming data in firestore
  // Stream<Config> get client {
  //   return userConfig.document(uid).snapshots().map(_configSnapshot);
  // }

  Stream<UserData> get userdata {
    return userConfig.document(uid).snapshots().map(_userDatasnapshot);
  }
}
