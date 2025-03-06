class OrderBookData {
  final DateTime timestamp;
  final List<List<double>> bids, asks;

  OrderBookData({
    required this.timestamp,
    required this.bids,
    required this.asks,
  });

  factory OrderBookData.fromJson(Map<String, dynamic> json) {
    return OrderBookData(
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['E']),
      bids: (json['bids'] as List)
          .map((bid) => [double.parse(bid[0]), double.parse(bid[1])])
          .toList(),
      asks: (json['asks'] as List)
          .map((ask) => [double.parse(ask[0]), double.parse(ask[1])])
          .toList(),
    );
  }
}
