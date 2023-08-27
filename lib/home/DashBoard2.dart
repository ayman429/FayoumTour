// ignore_for_file: file_names

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../Authentication/presentation/screens/profile/profile_screen.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';
import '../post/presentation/screens/add_post.dart';

class DashBoardScreen extends StatefulWidget {
  final int select;
  const DashBoardScreen({
    Key? key,
    required this.select,
  }) : super(key: key);
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List<Widget> screens = [
    profile_screen(type: "manger"),
    const AddPost(),
  ];
  static List<String> titles2 = [
    "My Profile",
    "FayTour Community",
  ];
  static List<String> titles2Ar = [
    "الملف الشخصي",
    "مجتمع فايتور"
  ];
  int selected = 0;
  List upIcons = [
    "assets/images/profileIconUp.png",
    "assets/images/comIconUp.png",
  ];
  @override
  void initState() {
    super.initState();
    selected = widget.select;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        appBar: AppBar(
          title: Text(
            sharedPreferences!.getString("Language") == "AR" ? titles2Ar[selected] : titles2[selected],
            style: sharedPreferences!.getString("Language") == "AR"
                        ? const TextStyle(
                            fontFamily: "galaxy",
                            fontWeight: FontWeight.bold,
                            fontSize: 28)
                        : const TextStyle(
                            fontFamily: AppStrings.fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)
          ),
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: Container(
            margin: sharedPreferences!.getString("Language") == "AR"
                ? const EdgeInsets.only(
                    right: 7,
                  )
                : const EdgeInsets.only(
                    left: 7,
                  ),
            child: Hero(
              tag: AppStrings.loginHeroTag,
              child: Image.asset(AppStrings.logoImage),
            ),
          ),
          actions: [
            Container(
              height: 42,
              width: 45,
              margin: sharedPreferences!.getString("Language") == "AR"
                  ? const EdgeInsets.only(left: 5)
                  : const EdgeInsets.only(right: 5),
              child: Hero(
                tag: AppStrings.loginHeroTag,
                child: Image.asset(upIcons[selected]),
              ),
            ),
          ],
        ),
        body: screens[selected],
        bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 200),
          color: Theme.of(context).colorScheme.tertiaryContainer,
          items: [
            Icon(
              selected == 0 ? Icons.person : Icons.person_outlined,
              size: 25,
              color: selected == 0 ? Colors.green : null,
            ),
            Icon(
              selected == 1 ? Icons.add_circle : Icons.add_circle_outline,
              size: 25,
              color: selected == 1 ? Colors.green : null,
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
