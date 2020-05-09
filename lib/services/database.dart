import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shibusindia/model/channel.dart';
import 'package:shibusindia/model/history.dart';
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
      'isCloud': false,
    });
  }

  Future addChannel({
    String name,
    String market,
    bool isstoploss,
    bool istrailing,
    double quantity,
    double stoploss,
    double trailingstoploss,
    double takeprofit,
    String profile,
    String blacklistword,
    String signal,
    double buypercent,
    double sellpercent,

    // recent signal shown in telegram Channel
  }) async {
    return await userConfig
        .document(uid)
        .collection('telegram')
        .document()
        .setData({
      'quantity': quantity ,
      'channelname': name,
      'markettype': market,
      'stoploss': stoploss,
      'isstoploss': isstoploss,
      'istrailing': istrailing,
      'takeprofit': takeprofit,
      'signal': signal,
      'buypercent': buypercent,
      'sellpercent': sellpercent,
      'traillingstoploss': trailingstoploss,
      'blacklistword': blacklistword,
      'profileimage': profile,
    });
  }

  Future updateConfigData({
    String username,
    String phone,
    String apikey,
    String secretkey,
    bool isCloud,
  }) async {
    return await userConfig.document(uid).updateData({
      'username': username,
      'apikey': apikey,
      'secretkey': secretkey,
      'phonenumber': phone,
      'isCloud': isCloud,
    });
  }

  Future updateStoploss({
    bool isTrailing, // trailing on or off
    bool isStoploss,
    String channelId,
  }) async {
    await userConfig
        .document(uid)
        .collection('telegram')
        .document(channelId)
        .updateData({
      'isstoploss': isStoploss,
      'istrailing': isTrailing,
    });
  }

  Future updateChannel({
    double quantity,
    String channelId,
    String market,
    String name,
    String profileImage,
    double buyPercent, // buy at percentage
    double sellPercent, //sell percentage
    //stoploss on or off
    double takeProfit, // take profit associated with trailing
    double
        trailingstoploss, // stoploss in traling, activate aftertake profit achieved.
    double stoploss, //Stoploss
    String signal,
    String blacklistWords, // recent signal shown in telegram Channel
  }) async {
    return await userConfig
        .document(uid)
        .collection('telegram')
        .document(channelId)
        .updateData({
      'quantity': quantity,
      'channelname': name,
      'markettype': market,
      'stoploss': stoploss,
      'trailingstoploss': trailingstoploss,
      'takeprofit': takeProfit,
      'signal': signal,
      'buypercent': buyPercent,
      'sellpercent': sellPercent,
      'blacklistword': blacklistWords,
      'profileimage': profileImage,
    });
  }

  Future deleteChannel({String channelId}) async {
    return await userConfig
        .document(uid)
        .collection('telegram')
        .document(channelId)
        .delete();
  }

  UserData _userDatasnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      username: snapshot.data['username'],
      apikey: snapshot.data['apikey'],
      secretkey: snapshot.data['secretkey'],
      phonenumber: snapshot.data['phonenumber'],
      iscloud: snapshot.data['isCloud'],
    );
  }

  List<ChannelsData> _userChannelData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ChannelsData(
        channelId: doc.documentID,
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
        amount: doc.data['quantity'],
        signal: doc.data['signal'],
        blacklistWords: doc.data['blacklistword'],
      );
    }).toList();
  }

  List<History> _userHistoryData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return History(
        buyAmount: doc.data['buyamount'],
        profit: doc.data['profit'],
        quantity: doc.data['quantity'],
        sellAmount: doc.data['sellamount'],
        signal: doc.data['signal'],
        status: doc.data['status'],
      );
    });
  }

  Stream<UserData> get userdata {
    return userConfig.document(uid).snapshots().map(_userDatasnapshot);
  }

  Stream<List<ChannelsData>> get getChannel {
    return userConfig
        .document(uid)
        .collection('telegram')
        .snapshots()
        .map(_userChannelData);
  }

  Stream<List<History>> get getHistory {
    return userConfig
        .document(uid)
        .collection('history')
        .snapshots()
        .map(_userHistoryData);
  }
}
