import 'package:flutter/material.dart';
import 'package:roqqu_assessment/assets.dart';
import 'package:roqqu_assessment/screens/widgets/charts.dart';
import 'package:roqqu_assessment/screens/widgets/exchange_details.dart';
import 'package:roqqu_assessment/screens/widgets/orderbook.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ['Charts', 'Orderbook', 'Recent trades'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const ExchangeDetails(),
                _buildTabSection(),
                const Transactions(),
              ],
            ),
          ),
          const BuySell(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            Theme.of(context).brightness == Brightness.dark
                ? AssetsPaths.logo
                : AssetsPaths.logoLight,
            width: 20.76,
            height: 34,
          ),
          const SizedBox(width: 5),
          Image.asset(
            Theme.of(context).brightness == Brightness.dark
                ? AssetsPaths.logoType
                : AssetsPaths.logoTypeLight,
            width: 100,
            height: 20,
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Image.asset(AssetsPaths.user, width: 50, height: 50),
            Image.asset(AssetsPaths.globe, width: 50, height: 50),
            _buildMenuButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _showPopupMenu(context, details.globalPosition),
      child: Image.asset(AssetsPaths.menu, width: 50, height: 50),
    );
  }

  void _showPopupMenu(BuildContext context, Offset position) {
    showMenu(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      context: context,
      position: RelativeRect.fromLTRB(
          position.dx, position.dy, position.dx, position.dy),
      items: [
        PopupMenuItem(
          child: SizedBox(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  color: const Color(0xffF8F8F9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xffcfd9ea))),
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Search",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xffa7b1bc),
                        fontSize: 18,
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: Color(0xff2764ff),
                      size: 40,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        _buildPopupMenuItem('Exchange'),
        _buildPopupMenuItem('Wallets'),
        _buildPopupMenuItem('Roqqu Hub'),
        _buildPopupMenuItem('Log out'),
      ],
    );
  }

  PopupMenuItem _buildPopupMenuItem(String text) {
    return PopupMenuItem(
      child: SizedBox(
        width: 150,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
    );
  }

  buildTabSection() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _selectedTab == 0
          ? const Charts(key: ValueKey('charts'))
          : const Orderbook(key: ValueKey('orderbook')),
    );
  }

  Widget _buildTabSection() {
    return Container(
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
          _buildTabBar(),
          _buildTabContent(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xff262932)
                  : Colors.transparent),
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xff1c2127)
              : const Color(0xfff1f1f1),
        ),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: List.generate(_tabs.length, (index) => _buildTab(index)),
        ),
      ),
    );
  }

  Widget _buildTab(int index) {
    final bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        width: 120,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xff262b32)
                  : const Color(0xffffffff)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          _tabs[index],
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _selectedTab == 0
          ? const Charts(key: ValueKey('charts'))
          : const Orderbook(key: ValueKey('orderbook')),
    );
  }
}
