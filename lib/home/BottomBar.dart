import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../core/utils/constance/strings_manager.dart';
import 'favourites.dart';
import 'home.dart';
import 'plan.dart';
import 'profile.dart';

class BottomBar extends StatefulWidget {
  final int select;
  const BottomBar({Key? key, required this.select}) : super(key: key);
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<Widget> Screens = [
    Profile(),
    Home(),
    Favourites(),
    Plan(),
  ];
  int selected = 0;
  @override
  void initState() {
    super.initState();
    selected = widget.select;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        appBar: AppBar(
          title: Text(
            AppStrings.titles[selected],
            style: const TextStyle(
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: selected == 2
              ? Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Hero(
                    tag: AppStrings.loginHeroTag,
                    child: Image.asset(AppStrings.logoImage),
                  ),
                )
              : null,
          actions: selected == 2
              ? [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 8, 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 6)
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.search,
                        size: 26,
                      ),
                    ),
                  ),
                ]
              : null,
        ),
        body: Screens[selected],
        bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 200),
          color: Theme.of(context).colorScheme.tertiaryContainer,
          items: const [
            Icon(
              Icons.person_outlined,
              size: 25,
            ),
            Icon(
              Icons.home,
              size: 25,
            ),
            Icon(
              Icons.favorite_outline,
              size: 25,
            ),
            Icon(
              Icons.padding_outlined,
              size: 25,
            ),
          ],
          onTap: (value) {
            setState(() {
              selected = value;
            });
          },
          index: selected,
        ));
  }
}
