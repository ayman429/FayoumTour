import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Authentication/domain/entities/user_details.dart';
import '../Authentication/presentation/components/validation.dart';
import '../Authentication/presentation/controller/authentication_bloc.dart';
import '../Authentication/presentation/controller/authentication_event.dart';
import '../Authentication/presentation/controller/authentication_state.dart';
import '../core/services/services_locator.dart';
import '../core/utils/app_localizations.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/enums.dart';
import '../core/utils/snackbar_message.dart';
import 'BottomBar.dart';

class TourismScreen extends StatefulWidget {
  const TourismScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TourismScreenState createState() => _TourismScreenState();
}

class _TourismScreenState extends State<TourismScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  int route = 0;
  String title = sharedPreferences!.getString("Language") == "AR"
      ? "حدد نوع السياحة"
      : "Select Tourism Type";
  List<String> options = [
    "Islamic antiquities\n",
    "Coptic antiquities",
    "Greek and Roman Antiquities\n",
    "Pharaonic antiquities\n"
  ];
  List<String> optionsAR = [
    "الآثار الإسلامية",
    "الآثار القبطية",
    "الآثار الرومانية",
    "الاثار الفرعونية"
  ];
  List<String> images = [
    "islamic.jpeg",
    "coptic.jpg",
    "greek.jpeg",
    "pharonic.jpg"
  ];

  final List<String> _selectedOption = ['', '', '',''];

  @override
  void initState() {
    super.initState();
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
      _selectedOption[route] = option;
      //print("---------------->");
      //print(option);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthenticationBloc>(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/backQuestions.png',
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
                          top: 70, bottom: 0, right: 15, left: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
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
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          title,
                                          style: sharedPreferences!.getString("Language") == "AR"
                                          ?  TextStyle(
                                            fontFamily: "ibmP",
                                            fontSize: (23 / 360) * MediaQuery.of(context).size.width,//23,
                                          )
                                          :  TextStyle(
                                            fontFamily: "aBeeZee",
                                            fontSize: (23 / 360) * MediaQuery.of(context).size.width,//23,
                                          )
                                        ),
                                      ),
                                      const Divider(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _onOptionSelected(options[0]);
                                        },
                                        child: AnimatedContainer(
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeInOut,
                                          width: _selectedOption[route] ==
                                                  options[0]
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.40
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                          height: _selectedOption[route] ==
                                                  options[0]
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.23
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.18,
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
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/${images[0]}',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        sharedPreferences!
                                                    .getString("Language") ==
                                                "AR"
                                            ? optionsAR[0]
                                            : options[0],
                                      style: sharedPreferences!.getString("Language") == "AR"
                                          ?  TextStyle(
                                            fontFamily: "ibmP",
                                            fontSize: (16 / 360) * MediaQuery.of(context).size.width,//16,
                                          )
                                          :  TextStyle(
                                            fontFamily: "aBeeZee",
                                            fontSize: (15 / 360) * MediaQuery.of(context).size.width,//15,
                                          ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _onOptionSelected(options[1]);
                                            },
                                            child: AnimatedContainer(
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve: Curves.easeInOut,
                                              width: _selectedOption[route] ==
                                                      options[1]
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.40
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                              height: _selectedOption[route] ==
                                                      options[1]
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.23
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.18,
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
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/${images[1]}',
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            sharedPreferences!.getString(
                                                        "Language") ==
                                                    "AR"
                                                ? optionsAR[1]
                                                : options[1],
                                                style: sharedPreferences!.getString("Language") == "AR"
                                          ?  TextStyle(
                                            fontFamily: "ibmP",
                                            fontSize: (16 / 360) * MediaQuery.of(context).size.width,//16,
                                          )
                                          :  TextStyle(
                                            fontFamily: "aBeeZee",
                                            fontSize: (15 / 360) * MediaQuery.of(context).size.width,//15,
                                          ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            _onOptionSelected(options[2]),
                                        child: AnimatedContainer(
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeInOut,
                                          width: _selectedOption[route] ==
                                                  options[2]
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.40
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                          height: _selectedOption[route] ==
                                                  options[2]
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.23
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.18,
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
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/${images[2]}',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        sharedPreferences!
                                                    .getString("Language") ==
                                                "AR"
                                            ? optionsAR[2]
                                            : options[2] ==
                                                    "Greek and Roman Antiquities\n"
                                                ? "Greek and Roman\n"
                                                : options[2],
                                                style: sharedPreferences!.getString("Language") == "AR"
                                          ?  TextStyle(
                                            fontFamily: "ibmP",
                                            fontSize: (16 / 360) * MediaQuery.of(context).size.width,//16,
                                          )
                                          :  TextStyle(
                                            fontFamily: "aBeeZee",
                                            fontSize: (15 / 360) * MediaQuery.of(context).size.width,//15,
                                          ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            _onOptionSelected(options[3]),
                                        child: AnimatedContainer(
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeInOut,
                                          width: _selectedOption[route] ==
                                                  options[3]
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.40
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                          height: _selectedOption[route] ==
                                                  options[3]
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.23
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.18,
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
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/${images[3]}',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        sharedPreferences!
                                                    .getString("Language") ==
                                                "AR"
                                            ? optionsAR[3]
                                            : options[3],
                                            style: sharedPreferences!.getString("Language") == "AR"
                                          ?  TextStyle(
                                            fontFamily: "ibmP",
                                            fontSize: (16 / 360) * MediaQuery.of(context).size.width,//16,
                                          )
                                          :  TextStyle(
                                            fontFamily: "aBeeZee",
                                            fontSize: (15 / 360) * MediaQuery.of(context).size.width,//15,
                                          ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: BlocConsumer<AuthenticationBloc,
                                  AuthenticationState>(
                                listener: (context, state) {
                                  if (state.updateuserDetailsState ==
                                      RequestState.loaded) {
                                    //print("--------------->");
                                    //print(_selectedOption[0]);
                                    sharedPreferences!.setString(
                                        "placeType", _selectedOption[0]);
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => BottomBar(
                                                select: 2, _selectedOption[0])),
                                        (route) => false);
                                  } else if (state.updateuserDetailsState ==
                                      RequestState.error) {
                                    Navigator.pop(context);
                                    //print("error: ${state.updateuserDetailsMessage}");
                                    String message;
                                    message = Validation.validationMessage(
                                        state.updateuserDetailsMessage);
                                    SnackBarMessage().showErrorSnackBar(
                                        message: message, context: context);
                                  }
                                },
                                builder: (context, state) {
                                  return Opacity(
                                    opacity:
                                        _selectedOption[route] == '' ? 0.5 : 1,
                                    child: TextButton(
                                        onPressed: () {
                                          if (_selectedOption[route] != '') {
                                            if (route == 0) {
                                              setState(() {
                                                title = sharedPreferences!
                                                            .getString(
                                                                "Language") ==
                                                        "AR"
                                                    ? "ماذا تفضل؟"
                                                    : "What do you prefer?";
                                                options = [
                                                  "Historical pyramids\n",
                                                  "Statues and \nMonuments",
                                                  "Temples\n",
                                                  "Sand Boarding\n"
                                                ];
                                                optionsAR = [
                                                  "الأهرامات التاريخية",
                                                  "التماثيل والآثار",
                                                  "المعابد",
                                                  "التزحلق على الرمال"
                                                ];
                                                images = [
                                                  "Historical.jpg",
                                                  "statues.jpg",
                                                  "temples.jpg",
                                                  "sand.jpg"
                                                ];
                                                route++;
                                              });
                                            } else if (route == 1) {
                                              setState(() {
                                                title = sharedPreferences!
                                                            .getString(
                                                                "Language") ==
                                                        "AR"
                                                    ? "ماذا تفضل؟"
                                                    : "What do you prefer?";
                                                options = [
                                                  "Water Sports\n",
                                                  "Waterfalls Area\n",
                                                  "Safari Trips \nand Camping",
                                                  "Natural Gardens\n"
                                                ];
                                                optionsAR = [
                                                  "رياضات مائية",
                                                  "مناطق الشلالات",
                                                  "رحلات السفاري والتخييم",
                                                  "الحدائق الطبيعية"
                                                ];
                                                images = [
                                                  "water.jpg",
                                                  "waterfalls.jpg",
                                                  "safari.jpg",
                                                  "natural.jpg"
                                                ];
                                                route++;
                                              });
                                            } else {
                                              //print("-------------------------");
                                              ///print(route);
                                              String model1Input =
                                                  "I Love ${_selectedOption[1]} , I Enjoy ${_selectedOption[2]}";
                                              UserDetails userDetails =
                                                  UserDetails(
                                                      placeType:
                                                          _selectedOption[0],
                                                      model1Input: model1Input);
                                              BlocProvider.of<
                                                          AuthenticationBloc>(
                                                      context)
                                                  .add(UpdateUserDetailsEvent(
                                                      userDetails: userDetails,
                                                      type: "username"));
                                              if (state.loginstate ==
                                                  RequestState.loading) {
                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (ctx) =>
                                                      const FractionallySizedBox(
                                                    widthFactor:
                                                        0.5, // Set the desired width factor (0.0 to 1.0)
                                                    child: AlertDialog(
                                                      content: SizedBox(
                                                        width: double.infinity,
                                                        height: 30,
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            }
                                          }
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
                                              vertical: 0, horizontal: 50),
                                          child: Text(
                                            // "Next",
                                            AppLocalizations.of(context)!
                                                .translate("Next"),
                                            style: TextStyle(
                                                fontFamily: sharedPreferences!.getString("Language") == "AR" ? "Mag" : "rye",
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary,
                                                fontSize: (20 / 360) * MediaQuery.of(context).size.width,//20
                                                ),
                                          ),
                                        )),
                                  );
                                },
                              ),
                            ),
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
      ),
    );
  }
}
