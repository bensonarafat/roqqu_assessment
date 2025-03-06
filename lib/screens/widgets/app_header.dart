import 'package:flutter/material.dart';
import 'package:roqqu_assessment/assets.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xff17181B)
                : const Color(0xffffffff),
            border: Border(
                bottom: BorderSide(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xff262932)
                        : const Color(0xfff1f1f1)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Theme.of(context).brightness == Brightness.dark
                    ? Image.asset(
                        AssetsPaths.logo,
                        width: 20.76,
                        height: 34,
                      )
                    : Image.asset(
                        AssetsPaths.logoLight,
                        width: 20.76,
                        height: 34,
                      ),
                const SizedBox(
                  width: 5,
                ),
                Theme.of(context).brightness == Brightness.dark
                    ? Image.asset(
                        AssetsPaths.logoType,
                        width: 100,
                        height: 20,
                      )
                    : Image.asset(
                        AssetsPaths.logoTypeLight,
                        width: 100,
                        height: 20,
                      ),
              ],
            ),
            Row(
              children: [
                Image.asset(
                  AssetsPaths.user,
                  width: 50,
                  height: 50,
                ),
                Image.asset(
                  AssetsPaths.globe,
                  width: 50,
                  height: 50,
                ),
                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    showMenu(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      context: context,
                      position: RelativeRect.fromLTRB(
                        details.globalPosition.dx,
                        details.globalPosition.dy,
                        details.globalPosition.dx,
                        details.globalPosition.dy,
                      ),
                      items: [
                        const PopupMenuItem(
                          child: Text(
                            'Exchange',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const PopupMenuItem(
                          child: Text(
                            'Wallets',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const PopupMenuItem(
                          child: Text(
                            'Roqqu Hub',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const PopupMenuItem(
                          child: Text(
                            'Log out',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  child: Image.asset(
                    AssetsPaths.menu,
                    width: 50,
                    height: 50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
