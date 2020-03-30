import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shibusindia/model/binance.dart';
import 'package:shibusindia/model/channel.dart';
import 'package:shibusindia/model/user.dart';
// import 'package:shibusindia/model/channel.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userConfig =
      Firestore.instance.collection('clients');
  final CollectionReference channels = Firestore.instance.collection('Channel');

  Future setConfigData({
    String username,
    String phone,
    String apikey,
    String secretkey,
    List<ChannelList> telegramSettings,
    Binance binanceData,
  }) async {
    return await userConfig.document(uid).setData({
      'username': username,
      'apikey': apikey,
      'secretkey': secretkey,
      'phonenumber': phone,
      'telegramSettings': telegramSettings,
      'binanceData': binanceData
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

  UserData _userDatasnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      username: snapshot.data['username'],
      apikey: snapshot.data['apikey'],
      secretkey: snapshot.data['secretkey'],
      phonenumber: snapshot.data['phonenumber'],
    );
  }

  List<ChannelList> _updateChannelSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ChannelList(
        buyPercent: doc.data['buyPercent'],
        sellPercent: doc.data['sellPercent'],
        type: doc.data['type'],
        isStoploss: doc.data['isStoploss'],
        isTrailing: doc.data['isTrailing'],
        market: doc.data['market'],
        name: doc.data['channelName'],
        profileImage: doc.data['image'],
        signal: doc.data['signal'],
        stoploss: doc.data['stoploss'],
        takeProfit: doc.data['takeProfit'],
        trailingStoploss: doc.data['trailingStoploss'],
      );
    }).toList();
  }

  Stream<UserData> get userdata {
    return userConfig.document(uid).snapshots().map(_userDatasnapshot);
  }

  Stream<List<ChannelList>> get channelList {
    return channels
        .document(uid)
        .collection('channel')
        .snapshots()
        .map(_updateChannelSnapshot);
  }
}
