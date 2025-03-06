import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../data/model/order_book.dart';

class OrderBookProvider extends ChangeNotifier {
  final String symbol = 'btcusdt';
  late WebSocketChannel _orderBookChannel;

  List<OrderBookEntry> _bids = [];
  List<OrderBookEntry> _asks = [];

  List<OrderBookEntry> get bids => _bids;
  List<OrderBookEntry> get asks => _asks;

  OrderBookProvider() {
    _connectOrderBookWebSocket();
  }

  void _connectOrderBookWebSocket() {
    _orderBookChannel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/$symbol@depth5'),
    );

    _orderBookChannel.stream.listen((data) {
      _handleOrderBookUpdate(jsonDecode(data));
    }, onError: (error) {
      _reconnect();
    });
  }

  void _handleOrderBookUpdate(Map<String, dynamic> data) {
    notifyListeners();
    final bids =
        (data['bids'] as List).map((e) => OrderBookEntry.fromList(e)).toList();

    final asks =
        (data['asks'] as List).map((e) => OrderBookEntry.fromList(e)).toList();

    _bids = bids;
    _asks = asks;

    notifyListeners();
  }

  void _reconnect() {
    Future.delayed(const Duration(seconds: 2), () {
      _connectOrderBookWebSocket();
    });
  }

  @override
  void dispose() {
    _orderBookChannel.sink.close();
    super.dispose();
  }
}
