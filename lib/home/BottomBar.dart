import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../core/utils/constance/strings_manager.dart';
import '../post/presentation/screens/add_post.dart';
import 'favourites.dart';
import 'home.dart';
import 'plan.dart';
import 'profile.dart';
import 'search.dart';
import 'nearst.dart';


late String tourtismTypes;

class BottomBar extends StatefulWidget {
  final int select;
  // String tourtismType;
  BottomBar(
    tourtismType, {
    Key? key,
    required this.select,
    // required this.tourtismType,
  }) : super(key: key) {
    tourtismTypes = tourtismType;
  }
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  // String tourtismTypes;
  // _BottomBarState(tourtismType) {
  //   tourtismTypes = tourtismType;
  // }

  List<Widget> Screens = [
    Profile(),
    NEAR(Loc: loc),
    Home(tourtismType: tourtismTypes),
    const AddPost(),
    Favorites(),
    const Plan(),
  ];
  final TextEditingController _searchController = TextEditingController();

  int selected = 0;
  bool search = false;
  int search_counter = 0;
  String _text = '';

  @override
  void initState() {
    super.initState();
    selected = widget.select;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        appBar: search
            ? AppBar(
                title: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search...',

                    border: InputBorder.none,
                    //prefixIcon: Icon(Icons.search)
                  ),
                  onChanged: (value) {
                    setState(() {
                      search_counter = 0;
                      _text = value;
                      // print(_text);
                    });
                  },
                ),
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Colors.transparent,
                elevation: 0,
                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                centerTitle: true,
                leading: InkWell(
                  onTap: () {
                    setState(() {
                      _searchController.clear();
                      _text = "";
                      search = false;
                    });
                  },
                  child: const Icon(Icons.arrow_back),
                ),
              )
            : AppBar(
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
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 6)
                            ],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                search = true;
                              });
                            },
                            child: const Icon(
                              Icons.search,
                              size: 26,
                            ),
                          ),
                        ),
                      ]
                    : null,
              ),
        body: search
            ? SEARCH(
                search_ketword: _text,
                search_count: search_counter,
              )
            : Screens[selected],
        bottomNavigationBar: search
            ? null
            : CurvedNavigationBar(
                height: 65,
                backgroundColor: Colors.transparent,
                animationDuration: const Duration(milliseconds: 200),
                color: Theme.of(context).colorScheme.tertiaryContainer,
                items: [
                  const Icon(
                    Icons.person_outlined,
                    size: 25,
                  ),
                  const Icon(
                      Icons.explore,
                      size: 25,
                    ),
                  
                  const Icon(
                    Icons.home,
                    size: 25,
                  ),
                  Icon(
                    selected == 2 ? Icons.add_circle : Icons.add_circle_outline,
                    size: 25,
                  ),
                  const Icon(
                    Icons.favorite_outline,
                    size: 25,
                  ),
                  const Icon(
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
