import 'package:fayoumtour/core/utils/constance/shared_pref.dart';
import 'package:flutter/material.dart';

import 'BottomBar.dart';

class TourismScreen extends StatefulWidget {
  @override
  _TourismScreenState createState() => _TourismScreenState();
}

class _TourismScreenState extends State<TourismScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  String _selectedOption = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, 1),
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
      sharedPreferences!.setString("selectedOption", _selectedOption);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://media.istockphoto.com/id/1430783122/photo/reflections-in-qarun-lake-in-the-desert-at-faiyum-oasis.jpg?s=612x612&w=0&k=20&c=tqGuuT5nPEBhI7LFkXib0_X_ONd2gjiNk8E5iMaEB3s=',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Expanded(
                child: SlideTransition(
                  position: _offsetAnimation,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 70, bottom: 8, right: 40, left: 35),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
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
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        'Select Tourism',
                                        style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Divider(
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
                          SizedBox(height: 16),
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
                                        duration: Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                        width: _selectedOption ==
                                                'Islamic antiquities'
                                            ? 180
                                            : 140,
                                        height: _selectedOption ==
                                                'Islamic antiquities'
                                            ? 180
                                            : 140,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                              'https://th.bing.com/th/id/R.3ed9f9cac4343a892c5a623e6b96e386?rik=40rBk65hhMaLXA&pid=ImgRaw&r=0',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text('Islamic antiquities')
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
                                            duration: Duration(seconds: 1),
                                            curve: Curves.easeInOut,
                                            width: _selectedOption ==
                                                    'Coptic antiquities'
                                                ? 180
                                                : 140,
                                            height: _selectedOption ==
                                                    'Coptic antiquities'
                                                ? 180
                                                : 140,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 3,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  'https://english.ahram.org.eg/Media/News/2022/1/9/42_2022-637773397396011486-601.jpg',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text('Coptic antiquities')
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
                                        duration: Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                        width: _selectedOption ==
                                                'Greek and Roman Antiquities'
                                            ? 180
                                            : 140,
                                        height: _selectedOption ==
                                                'Greek and Roman Antiquities'
                                            ? 180
                                            : 140,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'https://faytourimages.s3.amazonaws.com/image/86bde0a89c20966890af.jpeg',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text('Greek and Roman')
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          _onOptionSelected('Pharaonic relics'),
                                      child: AnimatedContainer(
                                        duration: Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                        width: _selectedOption ==
                                                'Pharaonic relics'
                                            ? 180
                                            : 140,
                                        height: _selectedOption ==
                                                'Pharaonic relics'
                                            ? 180
                                            : 140,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'https://faytourimages.s3.amazonaws.com/image/lohnenswerte-besichtigung.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text('Pharaonic relics')
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 10),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => BottomBar(
                                              select: 1, _selectedOption)),
                                      (route) => false);
                                },
                                child: Text("Next")),
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
