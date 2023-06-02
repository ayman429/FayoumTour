
import 'package:fayoumtour/core/utils/constance/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'BottomBar.dart';

class TourismScreen extends StatefulWidget {
  const TourismScreen({super.key});

  @override
  _TourismScreenState createState() => _TourismScreenState();
}

class _TourismScreenState extends State<TourismScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  String _selectedOption = '';
  // Future<void> saveUserDetails() async {
  //   UserDetails userDetails = await FavouritStorage().getUsersDetails();
  //   await sharedPreferences!.setString("USERID", userDetails.id);
  //   String image = userDetails.image ?? "";

  //   sharedPreferences!.setString("USER", json.encode(userDetails.toJson()));
  //   sharedPreferences!.setString("username", userDetails.username);
  //   // print("=================>");
  //   // print(image);
  //   // print(userDetails.id);
  //   // print("${userDetails.id}USERIMAGE");
  //   sharedPreferences!.setString("${userDetails.id}USERIMAGE", image);
  // }

  @override
  void initState() {
    super.initState();
    // saveUserDetails();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onOptionSelected(String option) {
    setState(() {
      _selectedOption = option;
      var userId = sharedPreferences!.getString("USERID");
      sharedPreferences!.setString("$userId selectedOption", _selectedOption);
    });
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/backQuestions.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: SlideTransition(
                  position: _offsetAnimation,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 70, bottom: 8, right: 40, left: 35),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SlideTransition(
                            position: _offsetAnimation,
                            child: FadeTransition(
                              opacity: _opacityAnimation,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children:  [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        'Select Tourism',
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 23,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.black26,
                                      thickness: 1.9,
                                      indent: 40,
                                      endIndent: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _onOptionSelected(
                                            'Islamic antiquities');
                                        // print("object");
                                        // Navigator.of(context).pushAndRemoveUntil(
                                        //     MaterialPageRoute(
                                        //         builder: (context) => BottomBar(
                                        //             select: 1,
                                        //             'Islamic antiquities')),
                                        //     (route) => false);
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                        width: _selectedOption ==
                                                'Islamic antiquities'
                                            ? MediaQuery.of(context).size.width*0.40
                                            : MediaQuery.of(context).size.width*0.35,
                                        height: _selectedOption ==
                                                'Islamic antiquities'
                                            ? MediaQuery.of(context).size.height*0.23
                                            : MediaQuery.of(context).size.height*0.18,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                          image: const DecorationImage(
                                            image: AssetImage(
                                              'assets/images/islamic.jpeg',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text('Islamic antiquities')
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _onOptionSelected(
                                                'Coptic antiquities');
                                            // Navigator.of(context)
                                            //     .pushAndRemoveUntil(
                                            //         MaterialPageRoute(
                                            //             builder: (context) =>
                                            //                 BottomBar(
                                            //                     select: 1,
                                            //                     'Coptic antiquities')),
                                            //         (route) => false);
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(seconds: 1),
                                            curve: Curves.easeInOut,
                                            width: _selectedOption ==
                                                    'Coptic antiquities'
                                                ? MediaQuery.of(context).size.width*0.40
                                                : MediaQuery.of(context).size.width*0.35,
                                            height: _selectedOption ==
                                                    'Coptic antiquities'
                                                ? MediaQuery.of(context).size.height*0.23
                                                : MediaQuery.of(context).size.height*0.18,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 3,
                                                  blurRadius: 7,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                              image: const DecorationImage(
                                                image: AssetImage(
                                              'assets/images/coptic.jpg',
                                            ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text('Coptic antiquities')
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () => _onOptionSelected(
                                          'Greek and Roman Antiquities'),
                                      child: AnimatedContainer(
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                        width: _selectedOption ==
                                                'Greek and Roman Antiquities'
                                            ? MediaQuery.of(context).size.width*0.40
                                            : MediaQuery.of(context).size.width*0.35,
                                        height: _selectedOption ==
                                                'Greek and Roman Antiquities'
                                            ? MediaQuery.of(context).size.height*0.23
                                            : MediaQuery.of(context).size.height*0.18,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                          image: const DecorationImage(
                                            image: AssetImage(
                                              'assets/images/greek.jpeg',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text('Greek and Roman')
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          _onOptionSelected('Pharaonic relics'),
                                      child: AnimatedContainer(
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                        width: _selectedOption ==
                                                'Pharaonic relics'
                                            ? MediaQuery.of(context).size.width*0.40
                                            : MediaQuery.of(context).size.width*0.35,
                                        height: _selectedOption ==
                                                'Pharaonic relics'
                                            ? MediaQuery.of(context).size.height*0.23
                                            : MediaQuery.of(context).size.height*0.18,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                          image: const DecorationImage(
                                            image: AssetImage(
                                              'assets/images/pharonic.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text('Pharaonic relics')
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => BottomBar(
                                              select: 1, _selectedOption)),
                                      (route) => false);
                                },
                                style: TextButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 50),
                                  child: Text("Next",
                                  style: GoogleFonts.rye(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    fontSize: 20),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
