import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import '../core/utils/constance/strings_manager.dart';

class Plan extends StatefulWidget {
  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  late List<AssetImage> _images;
  bool _isDialogOpen = false;

  @override
  void initState() {
    super.initState();
    _images = const [
      AssetImage(AppStrings.plan1Image),
      AssetImage(AppStrings.plan2Image),
      AssetImage(AppStrings.plan3Image),
      AssetImage(AppStrings.plan4Image),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppStrings.e1),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Blurred background when dialog is open
            AnimatedOpacity(
              opacity: _isDialogOpen ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),

            // Content
            SingleChildScrollView(
              child: Column(
                children: _buildImageWidgets(),
              ),
            ),

            // // App bar
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   right: 0,
            //   child: AppBar(
            //     backgroundColor: Colors.transparent,
            //     elevation: 0,
            //     title: Center(child: Text("Plans For You")),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildImageWidgets() {
    List<Widget> widgets = [];

    for (int i = 0; i < _images.length; i++) {
      widgets.add(
        Padding(
          padding:
              const EdgeInsets.only(top: 25, bottom: 25, left: 40, right: 40),
          child: GestureDetector(
            onTap: () => _showImageDialog(i),
            child: Hero(
              tag: "image$i",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image(
                  image: _images[i],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      );

      if (i < _images.length - 1) {
        widgets.add(SizedBox(height: 16.0));
        // Delay half second between images
        widgets.add(DelayedWidget(
          delay: Duration(milliseconds: 500),
          child: Divider(
            color: Colors.black,
          ),
        ));
        widgets.add(SizedBox(height: 16.0));
      }
    }

    return widgets;
  }

  void _showImageDialog(int index) {
    _setDialogOpen(true);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Hero(
            tag: "image$index",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: _images[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    ).then((_) => _setDialogOpen(false));
  }

  void _setDialogOpen(bool value) {
    setState(() {
      _isDialogOpen = value;
    });
  }
}

class DelayedWidget extends StatefulWidget {
  final Widget child;
  final Duration delay;

  DelayedWidget({
    required this.child,
    required this.delay,
  });

  @override
  _DelayedWidgetState createState() => _DelayedWidgetState();
}

class _DelayedWidgetState extends State<DelayedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.delay, vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
