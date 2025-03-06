import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roqqu_assessment/assets.dart';
import 'package:roqqu_assessment/constants.dart';
import 'package:roqqu_assessment/provider/chart_provider.dart';
import 'package:roqqu_assessment/screens/widgets/trading_chart.dart';

class Charts extends StatelessWidget {
  const Charts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        _buildTimeSelector(context),
        const SizedBox(height: 8),
        _buildDivider(),
        _buildChartOptions(context),
        _buildDivider(),
        const TradingChart(),
      ],
    );
  }

  Widget _buildTimeSelector(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          ...timeOptions.map(
              (Map<String, dynamic> time) => _buildTimeText(context, time)),
          const Icon(
            Icons.keyboard_arrow_down_sharp,
            size: 16,
            color: Color(0xff737a91),
          ),
          SizedBox(width: 40, child: Image.asset(AssetsPaths.candleChart)),
          _buildTimeText(context, {"key": "Fx", "value": null}),
        ],
      ),
    );
  }

  Widget _buildTimeText(context, Map<String, dynamic> text) {
    return Consumer<ChartProvider>(builder: (context, provider, _) {
      return GestureDetector(
        onTap: () {
          provider.updateInterval(text['value']);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: provider.interval == text['value']
                ? const Color(0xffCFD3D8)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            text['key'],
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: provider.interval == text['value']
                  ? const Color(0xff373b3f)
                  : const Color(0xffa7b1bc),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildDivider() {
    return Divider(
      color: const Color(0xffa7b1bc).withOpacity(.2),
      thickness: 0.5,
    );
  }

  Widget _buildChartOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          _buildOptionButton(context, "Trading view"),
          const SizedBox(width: 16),
          _buildOptionText("Depth"),
          const SizedBox(width: 16),
          Image.asset(AssetsPaths.expandAlt),
        ],
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xff353945)
            : const Color(0xfff1f1f1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildOptionText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Color(0xffa7b1bc),
      ),
    );
  }
}
