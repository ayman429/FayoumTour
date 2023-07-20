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
    const NEAR(),
    Home(tourtismType: tourtismTypes),
    const AddPost(),
    const Favorites(),
    const Plan(),
  ];

  List upIcons = [
    "assets/images/profileIconUp.png",
    "assets/images/nearbyIconUp.png",
    AppStrings.logoImage,
    "assets/images/comIconUp.png",
    "assets/images/favIconUp.png",
    "assets/images/plansIconUp.png"
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
                leading: Container(
                        
                        margin: const EdgeInsets.only(left: 8,),
                        child: Hero(
                          tag: AppStrings.loginHeroTag,
                          child: Image.asset(AppStrings.logoImage),
                        ),
                      ),
                    
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
                    : [
                      Container(
                        height: 42,
                        width:45,
                        margin: const EdgeInsets.only(right: 6),
                        child: Hero(
                          tag: AppStrings.loginHeroTag,
                          child: Image.asset(upIcons[selected]),
                        ),
                      ),
                    ],

              ),
        body: search
            ? SEARCH(
                search_ketword: _text,
                search_count: search_counter,
              )
            // : Screens[selected],
            : IndexedStack(index: selected, children: Screens),
        bottomNavigationBar: search
            ? null
            : CurvedNavigationBar(
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
                    selected == 1 ? Icons.explore : Icons.explore_outlined,
                    size: 25,
                    color: selected == 1 ? Colors.green : null,
                  ),
                  Icon(
                    selected == 2 ? Icons.home : Icons.home_outlined,
                    size: 25,
                    color: selected == 2 ? Colors.green : null,
                  ),
                  Icon(
                    selected == 3 ? Icons.add_circle : Icons.add_circle_outline,
                    size: 25,
                    color: selected == 3 ? Colors.green : null,
                  ),
                  Icon(
                    selected == 4 ? Icons.favorite : Icons.favorite_outline,
                    size: 25,
                    color: selected == 4 ? Colors.green : null,
                  ),
                  Icon(
                    selected == 5 ? Icons.padding_outlined : Icons.padding,
                    size: 25,
                    color: selected == 5 ? Colors.green : null,
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
