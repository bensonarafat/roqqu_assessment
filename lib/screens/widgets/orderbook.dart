import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roqqu_assessment/assets.dart';
import 'package:roqqu_assessment/data/model/order_book.dart';
import 'package:roqqu_assessment/provider/orderbook_provider.dart';
import 'package:roqqu_assessment/utility.dart';

class Orderbook extends StatelessWidget {
  const Orderbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderBookProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              _buildHeaderControls(context),
              const SizedBox(height: 8),
              _buildColumnHeaders(),
              _buildBidsSection(provider),
              _buildPriceIndicator(provider),
              _buildAsksSection(provider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeaderControls(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final controlBackgroundColor =
        isDarkMode ? const Color(0xff353945) : const Color(0xffcfd3d8);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: controlBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              child: Image.asset(AssetsPaths.bar1),
            ),
            SizedBox(
              width: 32,
              height: 32,
              child: Image.asset(AssetsPaths.bar1),
            ),
            SizedBox(
              width: 32,
              height: 32,
              child: Image.asset(AssetsPaths.bar1),
            ),
          ],
        ),
        Container(
          width: 63,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: controlBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          child: const Row(
            children: [
              Text(
                "10",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xff777e90),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColumnHeaders() {
    const headerStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color(0xffa7b1bc),
    );

    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Price", style: headerStyle),
              Text("(USDT)", style: headerStyle),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text("Amounts", style: headerStyle),
              Text(" (BTC)", style: headerStyle),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Total", style: headerStyle),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBidsSection(OrderBookProvider provider) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildOrderBookEntryList(
              provider.bids,
              (OrderBookEntry entry) => Utility.formatPrice(entry.price),
              const TextStyle(
                color: Color(0xffff6838),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildOrderBookEntryList(
              provider.bids,
              (entry) => entry.quantity.toStringAsFixed(6),
              const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _buildOrderBookEntryList(
              provider.bids,
              (entry) => entry.total.toStringAsFixed(2),
              const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceIndicator(OrderBookProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            provider.asks.isEmpty
                ? "--"
                : Utility.formatPrice(provider.asks.last.price),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xff25c26e),
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 5),
          Image.asset(AssetsPaths.hHigh24),
          const SizedBox(width: 5),
          Text(
            provider.bids.isEmpty
                ? "--"
                : Utility.formatPrice(provider.bids.last.price),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAsksSection(OrderBookProvider provider) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildOrderBookEntryList(
              provider.asks,
              (entry) => Utility.formatPrice(entry.price),
              const TextStyle(
                color: Color(0xff25c26e),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildOrderBookEntryList(
              provider.asks,
              (entry) => entry.quantity.toStringAsFixed(6),
              const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _buildOrderBookEntryList(
              provider.asks,
              (entry) => entry.total.toStringAsFixed(2),
              const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildOrderBookEntryList(
    List<OrderBookEntry> entries,
    String Function(OrderBookEntry) textExtractor,
    TextStyle textStyle,
  ) {
    if (entries.isEmpty) {
      return [];
    }

    return entries.map((entry) {
      return Container(
        margin: const EdgeInsets.all(3),
        child: Text(
          textExtractor(entry),
          style: textStyle,
        ),
      );
    }).toList();
  }
}
