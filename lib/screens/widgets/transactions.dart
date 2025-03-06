import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  int _selectedTab = 0;
  final List<String> _tabs = ['Open Orders', 'Position', 'Order History'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xff17181B)
            : const Color(0xffffffff),
        border: Border.all(
          width: 1,
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xff262932)
              : const Color(0xfff1f1f1),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xff262932)
                    : Colors.transparent,
              ),
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xff131417)
                  : const Color(0xfff1f1f1),
            ),
            margin: const EdgeInsets.only(left: 16),
            child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: _tabs.map((String tab) {
                  final index = _tabs.indexOf(tab);
                  final isSelected = _selectedTab == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTab = index),
                    child: Container(
                      width: 120,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).brightness == Brightness.dark
                                ? const Color(0xff21262c)
                                : const Color(0xffffffff)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tab,
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList()),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              bottom: 50,
            ),
            width: 294,
            child: const Column(
              children: [
                Text(
                  "No Open Orders",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
