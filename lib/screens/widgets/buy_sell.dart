import 'package:flutter/material.dart';
import 'package:roqqu_assessment/screens/widgets/appbutton.dart';
import 'package:roqqu_assessment/utility.dart';

class BuySell extends StatefulWidget {
  const BuySell({super.key});

  @override
  State<BuySell> createState() => _BuySellState();
}

class _BuySellState extends State<BuySell> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xff262b31)
              : const Color(0xffffffff),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xff262932)
                : const Color(0xfff1f1f1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 171,
              child: Appbutton(
                onPressed: () => Utility.showBuySellSheet(context),
                child: const Text(
                  "Buy",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            SizedBox(
              width: 171,
              child: Appbutton(
                color: const Color(0xffff554a),
                onPressed: () => Utility.showBuySellSheet(context),
                child: const Text(
                  "Sell",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
