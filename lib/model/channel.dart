class ChannelsData {
  final String channelId;
  final String market; // Ask or BId
  final String name; //channel name
  final String profileImage; // telegram display picture
  final double buyPercent; // buy at percentage
  final double sellPercent; //sell percentage
  bool isTrailing; // trailing on or off
  bool isStoploss; //stoploss on or off
  final double takeProfit; // take profit associated with trailing
  final double
      trailingStoploss; // stoploss in traling, activate aftertake profit achieved.
  final double stoploss; //Stoploss
  final String signal;
  final double amount;
  final String blacklistWords; // recent signal shown in telegram Channel

  ChannelsData({
    this.channelId,
    this.amount,
    this.blacklistWords,
    this.buyPercent,
    this.isTrailing,
    this.name,
    this.sellPercent,
    this.isStoploss,
    this.market,
    this.profileImage,
    this.signal,
    this.stoploss,
    this.takeProfit,
    this.trailingStoploss,
  });
}
