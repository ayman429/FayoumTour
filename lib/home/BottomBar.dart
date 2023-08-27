// ignore_for_file: file_names

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../Authentication/presentation/screens/profile/profile_screen.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';
import '../core/utils/youtubeController.dart';
import '../post/presentation/screens/add_post.dart';
import 'favourites.dart';
import 'home.dart';
import 'plan.dart';
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
  
  

  @override
  void initState() {
    super.initState();
    selected = widget.select;
  }
  
  List<Widget> screens =  [
    profile_screen(type: "user"),
    const NEAR(),
    Home(tourtismType: tourtismTypes),
    const AddPost(),
    // const FavoritesPlacesAndHotels(),
    const Favorites(),
    const Plan(),
  ];
  final controller = YoutubeControllerSingleton.youtubeController;
  
  List upIcons = [
    "assets/images/profileIconUp.png",
    "assets/images/nearbyIconUp.png",
    AppStrings.logoImage,
    "assets/images/comIconUp.png",
    "assets/images/favIconUp.png",
    "assets/images/plansIconUp.png"
  ];

  //final TextEditingController _searchController = TextEditingController();

  int selected = 0;

  //int search_counter = 0;
  //String _text = '';

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        appBar: AppBar(
                title: Text(AppStrings.titlesFunc(context, selected),
                    style: sharedPreferences!.getString("Language") == "AR"
                        ?  TextStyle(
                            fontFamily: "galaxy",
                            fontWeight: FontWeight.bold,
                            fontSize: (28/360)*MediaQuery.of(context).size.width,//28
                            )
                        :  TextStyle(
                            fontFamily: AppStrings.fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: (25/360)*MediaQuery.of(context).size.width,//25
                            )
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
                actions: selected == 2
                    ? [
                        Container(
                          margin:
                              sharedPreferences!.getString("Language") == "AR"
                                  ? const EdgeInsets.fromLTRB(9, 6, 0, 6)
                                  : const EdgeInsets.fromLTRB(0, 6, 9, 6),
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
                            onTap:() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SEARCH())),
                            child: const Icon(
                              Icons.search,
                              size: 26,
                            ),
                          ),
                        ),
                      ]
                    : [
                        Container(
                          height: (42/772)*MediaQuery.of(context).size.height,//42,
                          width: (45/360)*MediaQuery.of(context).size.width,//45,
                          margin:
                              sharedPreferences!.getString("Language") == "AR"
                                  ? const EdgeInsets.only(left: 5)
                                  : const EdgeInsets.only(right: 5),
                          child: Hero(
                            tag: AppStrings.loginHeroTag,
                            child: Image.asset(upIcons[selected]),
                          ),
                        ),
                      ],
              ),
        body: IndexedStack(index: selected, children: screens),
        bottomNavigationBar: CurvedNavigationBar(
                height: 65,
                backgroundColor: Colors.transparent,
                animationDuration: const Duration(milliseconds: 200),
                color: Theme.of(context).colorScheme.tertiaryContainer,
                items: [
                  Icon(
                    selected == 0 ? Icons.person : Icons.person_outlined,
                    size: (25/360)*MediaQuery.of(context).size.width,//25,
                    color: selected == 0 ? Colors.green : null,
                  ),
                  Icon(
                    selected == 1 ? Icons.explore : Icons.explore_outlined,
                    size: (25/360)*MediaQuery.of(context).size.width,//25,
                    color: selected == 1 ? Colors.green : null,
                  ),
                  Icon(
                    selected == 2 ? Icons.home : Icons.home_outlined,
                    size: (25/360)*MediaQuery.of(context).size.width,//25,
                    color: selected == 2 ? Colors.green : null,
                  ),
                  Icon(
                    selected == 3 ? Icons.add_circle : Icons.add_circle_outline,
                    size: (25/360)*MediaQuery.of(context).size.width,//25,
                    color: selected == 3 ? Colors.green : null,
                  ),
                  Icon(
                    selected == 4 ? Icons.favorite : Icons.favorite_outline,
                    size: (25/360)*MediaQuery.of(context).size.width,//25,
                    color: selected == 4 ? Colors.green : null,
                  ),
                  Icon(
                    selected == 5 ? Icons.padding_outlined : Icons.padding,
                    size: (25/360)*MediaQuery.of(context).size.width,//25,
                    color: selected == 5 ? Colors.green : null,
                  ),
                ],
                onTap: (value) {
                  setState(() {
                    selected = value;

                    if(selected != 2)
                    {controller.pause();}
                    
                  });
                },
                index: selected,
              ));
  }
}
