class OrderBookEntry {
  final double price;
  final double quantity;
  double get total => price * quantity;

  OrderBookEntry({required this.price, required this.quantity});

  factory OrderBookEntry.fromList(List<dynamic> list) {
    return OrderBookEntry(
        price: double.parse(list[0].toString()),
        quantity: double.parse(list[1].toString()));
  }
}

class OrderBook {
  final List<OrderBookEntry> bids;
  final List<OrderBookEntry> asks;
  final DateTime timestamp;

  OrderBook({required this.bids, required this.asks, required this.timestamp});
}
