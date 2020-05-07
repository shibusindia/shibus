import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shibusindia/model/blacklist.dart';
import 'package:shibusindia/model/channel.dart';
import 'package:shibusindia/model/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userConfig =
      Firestore.instance.collection('clients');
  Future setConfigData({
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

  Future addChannel({
    String market,
    String name,
    String profileImage,
    double buyPercent, // buy at percentage
    double sellPercent, //sell percentage
    bool isTrailing, // trailing on or off
    bool isStoploss, //stoploss on or off
    double takeProfit, // take profit associated with trailing
    double
        trailingStoploss, // stoploss in traling, activate aftertake profit achieved.
    double stoploss, //Stoploss
    String signal,
    List<Blacklistwords>
        blacklistWords, // recent signal shown in telegram Channel
  }) async {
    return await userConfig
        .document(uid)
        .collection('telegram')
        .document()
        .setData({
      'channelName': name,
      'markettype': market,
      'stoploss': stoploss,
      'isstoploss': isStoploss,
      'istrailing': isTrailing,
      'trailingstoploss': trailingStoploss,
      'takeProfit': takeProfit,
      'signal': signal,
      'buypercent': buyPercent,
      'sellPercent': sellPercent,
      'traillingstoploss': trailingStoploss,
      'blacklistword': blacklistWords,
      'profileimage': profileImage,
    });
  }

  Future updateConfigData({
    String username,
    String phone,
    String apikey,
    String secretkey,
  }) async {
    return await userConfig.document(uid).updateData({
      'username': username,
      'apikey': apikey,
      'secretkey': secretkey,
      'phonenumber': phone,
    });
  }

  Future updateChannel({
    String market,
    String name,
    String profileImage,
    double buyPercent, // buy at percentage
    double sellPercent, //sell percentage
    bool isTrailing, // trailing on or off
    bool isStoploss, //stoploss on or off
    double takeProfit, // take profit associated with trailing
    double
        trailingStoploss, // stoploss in traling, activate aftertake profit achieved.
    double stoploss, //Stoploss
    String signal,
    List<Blacklistwords>
        blacklistWords, // recent signal shown in telegram Channel
  }) async {
    return await userConfig
        .document(uid)
        .collection('telegram')
        .document()
        .updateData({
      'channelName': name,
      'markettype': market ??'ASK',
      'stoploss': stoploss ?? 2.0,
      'isstoploss': isStoploss?? false,
      'istrailing': isTrailing??true,
      'trailingstoploss': trailingStoploss??1.0,
      'takeProfit': takeProfit??1.0,
      'signal': signal ??' ',
      'buypercent': buyPercent ?? 0.0,
      'sellPercent': sellPercent ??1.0,
      'blacklistword': blacklistWords?? [],
      'profileimage': profileImage ??'',
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

  List<ChannelsData> _userChannelData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ChannelsData(
        name: doc.data['channelname'],
        market: doc.data['markettype'],
        stoploss: doc.data['stoploss'],
        trailingStoploss: doc.data['trailingstoploss'],
        isTrailing: doc.data['istrailing'],
        takeProfit: doc.data['takeprofit'],
        isStoploss: doc.data['isstoploss'],
        profileImage: doc.data['profileimage'],
        buyPercent: doc.data['buypercent'],
        sellPercent: doc.data['sellpercent'],
        signal: doc.data['signal'],
        blacklistWords: doc.data['blacklistword'],
      );
    }).toList();
  }

  Stream<UserData> get userdata {
    return userConfig.document(uid).snapshots().map(_userDatasnapshot);
  }

  Stream<List<ChannelsData>> get channelDatas {
    return userConfig
        .document(uid)
        .collection('telegram')
        .snapshots()
        .map(_userChannelData);
  }
}
