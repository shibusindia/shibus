class History {
  final double timeStamp;
  final double buyAmount;
  final double sellAmount;
  final String signal;
  final String status;
  final String quantity;
  final String profit;
  History({
    this.timeStamp,
    this.buyAmount,
    this.sellAmount,
    this.signal,
    this.profit,
    this.quantity,
    this.status,
  });
}
