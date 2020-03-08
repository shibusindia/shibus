import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userData = Firestore.instance.collection('Users');
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

  Future updateGeneralData({
    String email,
    String password,
    String phone,
    String apikey,
    String secretkey,
  }) async {
    return await userData.document(uid).setData({
      'email': email,
      'password': password,
      'apiKey': apikey,
      'secretKey': secretkey,
      'phoneNumber': phone
    });
  }
}
