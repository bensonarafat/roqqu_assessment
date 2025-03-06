import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roqqu_assessment/screens/widgets/app_inputfield.dart';
import 'package:roqqu_assessment/screens/widgets/appbutton.dart';

class Utility {
  static String formatPrice(double value) {
    final formatter = NumberFormat("#,##0.##");
    return formatter.format(value);
  }

  static showBuySellSheet(BuildContext context) {
    int selectedTab = 0;
    final List<String> tabs = ['Buy', 'Sell'];
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xff20252b)
            : const Color(0xffffffff),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              height: 750,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xff262932)
                              : const Color(0xfff1f1f1)),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xff131417)
                          : const Color(0xfff1f1f1),
                    ),
                    child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: tabs.map((String tab) {
                          final index = tabs.indexOf(tab);
                          final isSelected = selectedTab == index;
                          return GestureDetector(
                            onTap: () => setState(() => selectedTab = index),
                            child: Container(
                              width: 161,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(2),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xff21262c)
                                        : const Color(0xffffffff)
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
                                      ? Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : null
                                      : const Color(0xffa7b1bc),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }).toList()),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 9, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xff353945)
                              : const Color(0xffcfd3d8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Limit",
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xfffcfcfd)
                                    : Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 9, horizontal: 15),
                          child: const Text(
                            "Market",
                            style: TextStyle(
                              color: Color(0xff777e90),
                            ),
                          )),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 9, horizontal: 15),
                        child: const Text(
                          "Stop-Limit",
                          style: TextStyle(
                            color: Color(0xff777e90),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppInputField(
                    prefix: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Limit price",
                            style: TextStyle(
                              color: Color(0xffa7b1bc),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.info_outline,
                            color: Color(0xffa7b1bc),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                    suffix: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "0.00 USD",
                        style: TextStyle(
                          color: Color(0xffa7b1bc),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppInputField(
                      prefix: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Amount",
                              style: TextStyle(
                                color: Color(0xffa7b1bc),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.info_outline,
                              color: Color(0xffa7b1bc),
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                      suffix: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          "0.00 USD",
                          style: TextStyle(
                            color: Color(0xffa7b1bc),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  const AppInputField(
                    prefix: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Type",
                            style: TextStyle(
                              color: Color(0xffa7b1bc),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.info_outline,
                            color: Color(0xffa7b1bc),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                    suffix: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Good till cancelled",
                            style: TextStyle(
                              color: Color(0xffa7b1bc),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xffa7b1bc),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (v) {},
                        side: const BorderSide(
                          color: Color(0xff373b3f),
                        ),
                      ),
                      const Text(
                        "Post Only",
                        style: TextStyle(
                          color: Color(0xffa7b1bc),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Icons.info_outline,
                        color: Color(0xffa7b1bc),
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          color: Color(0xffa7b1bc),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "0.00",
                        style: TextStyle(
                          color: Color(0xffa7b1bc),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    child: Appbutton(
                      onPressed: () {},
                      gradient: const [
                        Color(0xff483beb),
                        Color(0xff7847e1),
                        Color(0xffdd568d),
                      ],
                      child: const Text(
                        "Buy BTC",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 16,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total account value",
                            style: TextStyle(
                              color: Color(0xffa7b1bc),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "0.00",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "NGN",
                            style: TextStyle(
                              color: Color(0xffa7b1bc),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Open Orders",
                            style: TextStyle(
                              color: Color(0xffa7b1bc),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "0.00",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Available",
                            style: TextStyle(
                              color: Color(0xffa7b1bc),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "0.00",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 80,
                    child: Appbutton(
                      onPressed: () {},
                      color: const Color(0xff2764ff),
                      child: const Text(
                        "Deposit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}
