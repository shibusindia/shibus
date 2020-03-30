import 'package:shibusindia/model/blacklist.dart';

class ChannelList {
  final String type; //private or public
  final String market; // Ask or BId
  final String name; //channel name
  final String profileImage; // telegram display picture
  final double buyPercent; // buy at percentage
  final double sellPercent; //sell percentage
  final bool isTrailing; // trailing on or off
  final bool isStoploss; //stoploss on or off
  final double takeProfit; // take profit associated with trailing
  final double
      trailingStoploss; // stoploss in traling, activate aftertake profit achieved.
  final double stoploss; //Stoploss
  final String signal;
  final List<Blacklistwords>
      blacklistWords; // recent signal shown in telegram Channel
  ChannelList({
    this.name,
    this.profileImage,
    this.buyPercent,
    this.isStoploss,
    this.isTrailing,
    this.sellPercent,
    this.signal,
    this.stoploss,
    this.takeProfit,
    this.trailingStoploss,
    this.market,
    this.type,
    this.blacklistWords,
  });
}
