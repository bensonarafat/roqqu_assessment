import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:roqqu_assessment/data/model/kline_data.dart';
import 'package:roqqu_assessment/provider/chart_provider.dart';
import 'package:roqqu_assessment/utility.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TradingChart extends StatelessWidget {
  const TradingChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChartProvider>(
      builder: (context, provider, child) {
        return _buildKlineStream(provider);
      },
    );
  }
}

Widget _buildKlineStream(ChartProvider provider) {
  return Column(
    children: [
      // Header with price info
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: 23,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.keyboard_arrow_down_sharp, size: 16),
              ),
              const SizedBox(width: 8),
              const Text(
                'BTC/USDT',
              ),
              const SizedBox(width: 16),
              const Text(
                'O',
              ),
              const SizedBox(width: 4),
              Text(
                  provider.isLoading
                      ? "--"
                      : Utility.formatPrice(provider.candleData.last.open),
                  style: const TextStyle(color: Colors.green)),
              const SizedBox(width: 16),
              const Text(
                'H',
              ),
              const SizedBox(width: 4),
              Text(
                  provider.isLoading
                      ? "--"
                      : Utility.formatPrice(provider.candleData.last.high),
                  style: const TextStyle(color: Colors.green)),
              const SizedBox(width: 16),
              const Text(
                'L',
              ),
              const SizedBox(width: 4),
              Text(
                  provider.isLoading
                      ? "--"
                      : Utility.formatPrice(provider.candleData.last.low),
                  style: const TextStyle(color: Colors.green)),
              const SizedBox(width: 16),
              const Text(
                'C',
              ),
              const SizedBox(width: 4),
              Text(
                  provider.isLoading
                      ? "--"
                      : Utility.formatPrice(provider.candleData.last.close),
                  style: const TextStyle(color: Colors.green)),
            ],
          ),
        ),
      ),
      // Chart area
      Container(
        child: provider.isLoading
            ? const SizedBox(height: 300, child: CupertinoActivityIndicator())
            : _buildChartWithVolume(provider),
      ),
    ],
  );
}

Widget _buildChartWithVolume(ChartProvider provider) {
  return Stack(
    children: [
      SfCartesianChart(
        plotAreaBorderWidth: 0,
        legend: const Legend(isVisible: false),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: InteractiveTooltip(
            enable: true,
            color: Colors.grey[800],
          ),
          lineType: TrackballLineType.vertical,
          lineColor: Colors.white24,
          lineDashArray: const <double>[5, 5],
        ),
        primaryXAxis: const DateTimeAxis(
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(width: 0),
          labelStyle: TextStyle(color: Colors.grey),
          isVisible:
              false, // Hide X-axis labels as they'll be in the bottom chart
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(
            width: 0.5,
            color: Colors.grey.withOpacity(0.2),
            dashArray: const <double>[5, 5],
          ),
          axisLine: const AxisLine(width: 0),
          labelStyle: const TextStyle(color: Colors.grey),
          numberFormat: NumberFormat.currency(symbol: '', decimalDigits: 2),
          opposedPosition: true, // Show labels on the right side
        ),
        series: <CartesianSeries>[
          CandleSeries<KlineData, DateTime>(
            dataSource: provider.candleData,
            xValueMapper: (KlineData data, _) => data.openTime,
            lowValueMapper: (KlineData data, _) => data.low,
            highValueMapper: (KlineData data, _) => data.high,
            openValueMapper: (KlineData data, _) => data.open,
            closeValueMapper: (KlineData data, _) => data.close,
            bullColor: Colors.green,
            bearColor: Colors.red,
            enableSolidCandles: true,
          ),
        ],
      ),
      // Bottom section with volume chart
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        height: 100,
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: const DateTimeAxis(
            majorGridLines: MajorGridLines(width: 0),
            axisLine: AxisLine(width: 0),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 10),
          ),
          primaryYAxis: NumericAxis(
            majorGridLines: const MajorGridLines(width: 0),
            axisLine: const AxisLine(width: 0),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 10),
            opposedPosition: true,
            maximum: provider.candleData
                    .map((data) => data.volume)
                    .reduce((a, b) => a > b ? a : b) *
                1.2,
          ),
          series: <CartesianSeries>[
            ColumnSeries<KlineData, DateTime>(
              dataSource: provider.candleData,
              xValueMapper: (KlineData data, _) => data.openTime,
              yValueMapper: (KlineData data, _) => data.volume,
              pointColorMapper: (KlineData data, _) => data.close > data.open
                  ? Colors.green.withOpacity(0.7)
                  : Colors.red.withOpacity(0.7),
              borderRadius: BorderRadius.zero,
              width: 0.8,
              spacing: 0.2,
            )
          ],
        ),
      ),

      // Volume info text
      Positioned(
        left: 16,
        bottom: 80,
        child: Text(
          'Vol(BTC): ${provider.candleData.last.volume}',
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ),

      Positioned(
        right: 16,
        bottom: 80,
        child: Text(
          'Vol(USDT): ${(provider.candleData.last.volume * provider.candleData.last.close).toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ),
    ],
  );
}
