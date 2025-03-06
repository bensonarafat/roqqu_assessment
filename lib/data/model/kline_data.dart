class KlineData {
  final double open, high, low, close, volume;
  final DateTime openTime, closeTime;

  KlineData({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.openTime,
    required this.closeTime,
    required this.volume,
  });
}
