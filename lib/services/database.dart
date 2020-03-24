import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shibusindia/model/user.dart';
// import 'package:shibusindia/model/channel.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userConfig =
      Firestore.instance.collection('clients');
  final CollectionReference channels = Firestore.instance.collection('Channel');

  Future updateChannelSetting({
    String type, //private or public
    String market, // Ask or BId
    String name, //channel name
    String profileImage, // telegram display picture
    double buyPercent, // buy at percentage
    double sellPercent, //sell percentage
    bool isTrailing, // trailing on or off
    bool isStoploss, //stoploss on or off
    double takeProfit, // take profit associated with trailing
    double
        trailingStoploss, // stoploss in traling, activate aftertake profit achieved.
    double stoploss, //Stoploss
    String signal, // recent signal shown in telegram Channel
    String uid,
  }) async {
    return await channels.document(uid).updateData({
      'uid': uid,
      'type': type,
      'market': market,
      'name': name,
      'profileImage': profileImage,
      'buyAtPercent': buyPercent,
      'sellAtPetcent': sellPercent,
      'isTrailing': isTrailing,
      'isStoploss': isStoploss,
      'takeProfit': takeProfit,
      'trailingStoploss': trailingStoploss,
      'stoploss': stoploss,
      'signal': signal,
    });
  }

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
      'phonenumber': phone,
    });
  }

  UserData _userDatasnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      username: snapshot.data['username'],
      apikey: snapshot.data['apikey'],
      secretkey: snapshot.data['secretkey'],
      phonenumber: snapshot.data['phonenumber'],
    );
  }
//   List<ChannelList> _updateChannelSnapshot(DocumentSnapshot snapshot) {
//   return ChannelList(
//     buyPercent: snapshot.data['buyPercent'],
//     sellPercent: snapshot.data['sellPercent'],
//     type: snapshot.data['type'],
//     isStoploss: snapshot.data['isStoploss'],
//     isTrailing: snapshot.data['isTrailing'],
//     market: snapshot.data['market'],
//     name: snapshot.data['channelName'],
//     profileImage: snapshot.data['image'],
//     signal: snapshot.data['signal'],
//     stoploss: snapshot.data['stoploss'],
//     takeProfit: snapshot.data['takeProfit'],
//     trailingStoploss: snapshot.data['trailingStoploss'],
//     uid: uid
//   );
// }


  Stream<UserData> get userdata {
    return userConfig.document(uid).snapshots().map(_userDatasnapshot);
  }
}


