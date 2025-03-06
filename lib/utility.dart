import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roqqu_assessment/screens/widgets/app_inputfield.dart';
import 'package:roqqu_assessment/screens/widgets/appbutton.dart';

class Utility {
  static String formatPrice(double value) {
    return NumberFormat("#,##0.##").format(value);
  }

  static showBuySellSheet(BuildContext context) {
    int selectedTab = 0;
    final List<String> tabs = ['Buy', 'Sell'];
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: isDarkMode ? const Color(0xff20252b) : Colors.white,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              height: 750,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  _buildTabSelector(context, tabs, selectedTab, setState),
                  const SizedBox(height: 16),
                  _buildOrderTypeSelector(isDarkMode),
                  const SizedBox(height: 16),
                  _buildInputField("Limit price"),
                  const SizedBox(height: 16),
                  _buildInputField("Amount"),
                  const SizedBox(height: 16),
                  _buildTypeSelector(),
                  const SizedBox(height: 16),
                  _buildPostOnlyCheckbox(),
                  const SizedBox(height: 16),
                  _buildTotalRow(),
                  const SizedBox(height: 16),
                  _buildBuyButton(),
                  const Divider(height: 16),
                  _buildAccountDetails(),
                  const SizedBox(height: 16),
                  _buildDepositButton(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static Widget _buildTabSelector(BuildContext context, List<String> tabs,
      int selectedTab, StateSetter setState) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color:
                isDarkMode ? const Color(0xff262932) : const Color(0xfff1f1f1)),
        color: isDarkMode ? const Color(0xff131417) : const Color(0xfff1f1f1),
      ),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = selectedTab == index;
          return GestureDetector(
            onTap: () => setState(() => selectedTab = index),
            child: Container(
              width: 161,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDarkMode ? const Color(0xff21262c) : Colors.white)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: isSelected
                    ? Border.all(color: const Color(0xff25c26e))
                    : null,
              ),
              child: Text(
                tab,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected
                      ? (isDarkMode ? Colors.white : Colors.black)
                      : const Color(0xffa7b1bc),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  static Widget _buildOrderTypeSelector(bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildOrderTypeButton("Limit", isDarkMode, true),
        _buildOrderTypeButton("Market", isDarkMode, false),
        _buildOrderTypeButton("Stop-Limit", isDarkMode, false),
      ],
    );
  }

  static Widget _buildOrderTypeButton(
      String label, bool isDarkMode, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
      decoration: BoxDecoration(
        color: isSelected
            ? (isDarkMode ? const Color(0xff353945) : const Color(0xffcfd3d8))
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? (isDarkMode ? const Color(0xfffcfcfd) : Colors.black)
              : const Color(0xff777e90),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  static Widget _buildInputField(String label) {
    return AppInputField(
      prefix: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(label, style: const TextStyle(color: Color(0xffa7b1bc))),
            const SizedBox(width: 5),
            const Icon(Icons.info_outline, color: Color(0xffa7b1bc), size: 16),
          ],
        ),
      ),
      suffix: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("0.00 USD", style: TextStyle(color: Color(0xffa7b1bc))),
      ),
    );
  }

  static Widget _buildTypeSelector() {
    return _buildInputField("Type");
  }

  static Widget _buildPostOnlyCheckbox() {
    return Row(
      children: [
        Checkbox(
            value: false,
            onChanged: (v) {},
            side: const BorderSide(color: Color(0xff373b3f))),
        const Text("Post Only", style: TextStyle(color: Color(0xffa7b1bc))),
        const SizedBox(width: 4),
        const Icon(Icons.info_outline, color: Color(0xffa7b1bc), size: 16),
      ],
    );
  }

  static Widget _buildTotalRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Total",
            style: TextStyle(
                color: Color(0xffa7b1bc), fontWeight: FontWeight.w500)),
        Text("0.00",
            style: TextStyle(
                color: Color(0xffa7b1bc), fontWeight: FontWeight.w500)),
      ],
    );
  }

  static Widget _buildBuyButton() {
    return Appbutton(
      onPressed: () {},
      gradient: const [Color(0xff483beb), Color(0xff7847e1), Color(0xffdd568d)],
      child: const Text("Buy BTC",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
    );
  }

  static Widget _buildAccountDetails() {
    return const Text("Account Details Placeholder");
  }

  static Widget _buildDepositButton() {
    return Appbutton(
        onPressed: () {},
        color: const Color(0xff2764ff),
        child: const Text("Deposit",
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w700)));
  }
}
