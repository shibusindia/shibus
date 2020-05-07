import 'package:shibusindia/model/history.dart';

class Binance {
  double balanceAmount;
  List<History> history;
  Binance.fromMap(Map<dynamic, dynamic> data)
      : balanceAmount = data['balanceAmount'],
        history = List.from(data['history']);
}
