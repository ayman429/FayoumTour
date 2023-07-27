import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';
import '../post/presentation/screens/add_post.dart';
import 'profile.dart';

class DashBoardScreen extends StatefulWidget {
  final int select;
  DashBoardScreen({
    Key? key,
    required this.select,
  }) : super(key: key) {}
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List<Widget> Screens = [
    Profile(),
    const AddPost(),
  ];
  static List<String> titles2 = [
    sharedPreferences!.getString("Language") == "AR"
        ? "الملف الشخصي"
        : "My Profile",
    sharedPreferences!.getString("Language") == "AR"
        ? "مجتمع فايتور"
        : "FayTour Community",
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
            titles2[selected],
            style: const TextStyle(
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: selected == 1
              ? Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Hero(
                    tag: AppStrings.loginHeroTag,
                    child: Image.asset(AppStrings.logoImage),
                  ),
                )
              : null,
          actions: null,
        ),
        body: Screens[selected],
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
              selected == 3 ? Icons.add_circle : Icons.add_circle_outline,
              size: 25,
              color: selected == 3 ? Colors.green : null,
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
