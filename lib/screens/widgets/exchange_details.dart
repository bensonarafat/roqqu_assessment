import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roqqu_assessment/assets.dart';
import 'package:roqqu_assessment/provider/chart_provider.dart';
import 'package:roqqu_assessment/utility.dart';

class ExchangeDetails extends StatelessWidget {
  const ExchangeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDarkMode ? const Color(0xff17181B) : const Color(0xffffffff);
    final borderColor =
        isDarkMode ? const Color(0xff262932) : const Color(0xfff1f1f1);
    final subTextColor =
        isDarkMode ? const Color(0xffa7b1bc) : const Color(0xff737A91);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          width: 1,
          color: borderColor,
        ),
      ),
      child: Consumer<ChartProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              _buildCurrencyHeader(provider),
              const SizedBox(height: 16),
              _buildMetricsScrollView(context, provider, subTextColor),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCurrencyHeader(ChartProvider provider) {
    return Row(
      children: [
        _buildCurrencyIcons(),
        const SizedBox(width: 5),
        const Text(
          "BTC/USDT",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 5),
        const Icon(Icons.keyboard_arrow_down_rounded),
        const SizedBox(width: 5),
        Text(
          provider.isLoading
              ? "--"
              : "\$${Utility.formatPrice(provider.candleData.last.close)}",
          style: const TextStyle(
            color: Color(0xff00c076),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrencyIcons() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Image.asset(AssetsPaths.btc),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Image.asset(AssetsPaths.usdt),
        ),
      ],
    );
  }

  Widget _buildMetricsScrollView(
    BuildContext context,
    ChartProvider provider,
    Color subTextColor,
  ) {
    return SizedBox(
      height: 50,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          _buildMetricContainer(
            icon: AssetsPaths.hChange24,
            title: "24h change",
            value: provider.isLoading
                ? "--"
                : Utility.formatPrice(provider.candleData.last.close),
            percentage: "+1.25%",
            isGreen: true,
            subTextColor: subTextColor,
            showBorder: true,
          ),
          _buildMetricContainer(
            icon: AssetsPaths.hHigh24,
            title: "24h high",
            value: provider.isLoading
                ? "--"
                : Utility.formatPrice(provider.candleData.last.high),
            percentage: "+1.25%",
            isGreen: false,
            subTextColor: subTextColor,
            showBorder: true,
            marginLeft: 16,
          ),
          _buildMetricContainer(
            icon: AssetsPaths.hLow24,
            title: "24h low",
            value: provider.isLoading
                ? "--"
                : Utility.formatPrice(provider.candleData.last.low),
            percentage: "+1.25%",
            isGreen: false,
            subTextColor: subTextColor,
            showBorder: false,
            marginLeft: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricContainer({
    required String icon,
    required String title,
    required String value,
    required String percentage,
    required bool isGreen,
    required Color subTextColor,
    required bool showBorder,
    double marginLeft = 0,
  }) {
    final valueTextStyle = TextStyle(
      color: isGreen ? const Color(0xff00C076) : null,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );

    return Container(
      width: 130,
      margin: EdgeInsets.only(left: marginLeft),
      decoration: BoxDecoration(
        border: showBorder
            ? Border(
                right: BorderSide(
                  color: const Color(0xffa7b1bc).withOpacity(.1),
                ),
              )
            : null,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(icon),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(color: subTextColor),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(value, style: valueTextStyle),
              const SizedBox(width: 5),
              Text(percentage, style: valueTextStyle),
            ],
          ),
        ],
      ),
    );
  }
}
