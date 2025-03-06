import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:roqqu_assessment/data/model/kline_data.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChartProvider extends ChangeNotifier {
  List<KlineData> _candleData = [];
  bool _isLoading = true;
  String symbol = 'btcusdt';
  String _interval = '1d';
  late WebSocketChannel _klineChannel;

  List<KlineData> get candleData => _candleData;
  bool get isLoading => _isLoading;
  String get interval => _interval;
  ChartProvider() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    await fetchHistoricalData();
    connectWebSocket();
  }

  Future<void> fetchHistoricalData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.binance.com/api/v3/klines?symbol=${symbol.toUpperCase()}&interval=$_interval&limit=100'));

      if (response.statusCode == 200) {
        _candleData = (jsonDecode(response.body) as List)
            .map((e) => KlineData(
                  openTime: DateTime.fromMillisecondsSinceEpoch(e[0]),
                  open: double.parse(e[1]),
                  high: double.parse(e[2]),
                  low: double.parse(e[3]),
                  close: double.parse(e[4]),
                  volume: double.parse(e[5]),
                  closeTime: DateTime.fromMillisecondsSinceEpoch(e[6]),
                ))
            .toList();
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  void connectWebSocket() {
    _klineChannel = WebSocketChannel.connect(Uri.parse(
        'wss://stream.binance.com:9443/stream?streams=$symbol@kline_$_interval'));

    _klineChannel.stream.listen((message) {
      final decoded = jsonDecode(message);
      if (decoded['data']?['k'] != null) {
        final k = decoded['data']['k'];
        _updateCandleData(KlineData(
          openTime: DateTime.fromMillisecondsSinceEpoch(k['t']),
          closeTime: DateTime.fromMillisecondsSinceEpoch(k['T']),
          open: double.parse(k['o']),
          high: double.parse(k['h']),
          low: double.parse(k['l']),
          close: double.parse(k['c']),
          volume: double.parse(k['v']),
        ));
      }
    });
  }

  void _updateCandleData(KlineData newCandle) {
    final index = _candleData.indexWhere((c) =>
        c.openTime.millisecondsSinceEpoch ==
        newCandle.openTime.millisecondsSinceEpoch);

    if (index >= 0) {
      _candleData[index] = newCandle;
    } else {
      _candleData.add(newCandle);
    }
    notifyListeners();
  }

  void updateInterval(String newInterval) {
    if (_interval == newInterval) return;
    _interval = newInterval;
    fetchHistoricalData();
    connectWebSocket();
    notifyListeners();
  }

  @override
  void dispose() {
    _klineChannel.sink.close();

    super.dispose();
  }
}
