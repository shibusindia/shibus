import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userData = Firestore.instance.collection('Users');

  Future updateGeneralData(
      {String email,
      String password,
      String phone,
      String apikey,
      String secretkey}) async {
    return await userData.document(uid).setData({
      'email': email,
      'password': password,
      'apiKey': apikey,
      'secretKey': secretkey,
      'phoneNumber': phone
    });
  }
}
