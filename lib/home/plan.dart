import '../core/utils/constance/strings_manager.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan>
    with SingleTickerProviderStateMixin {
  late List<AssetImage> _images;
  final List<String> _imageTexts = [
    "This is the first plan",
    "This is the second plan",
    "This is the third plan",
    "This is the fourth plan",
  ];
  bool _isDialogOpen = false;
  bool _isSoundPlaying = false;
  FlutterTts flutterTts = FlutterTts();
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _images = [
      const AssetImage(AppStrings.plan1Image),
      const AssetImage(AppStrings.plan2Image),
      const AssetImage(AppStrings.plan3Image),
      const AssetImage(AppStrings.plan4Image),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
    audioPlayer.stop();
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
                  image: AssetImage("assets/images/e1.jpg"),
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

            // App bar
            
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
        widgets.add(const SizedBox(height: 16.0));
        // Delay half second between images
        widgets.add(const DelayedWidget(
          delay: Duration(milliseconds: 500),
          child: Divider(
            color: Colors.black,
          ),
        ));
        widgets.add(const SizedBox(height: 16.0));
      }
    }

    return widgets;
  }

  Future<void> _showImageDialog(int index) async {
    _setDialogOpen(true);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Hero(
                tag: "image$index",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: _images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 16.0,
                right: 16.0,
                child: GestureDetector(
                  onTap: () => _toggleSound(index),
                  child: Icon(
                    _isSoundPlaying ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                    size: 32.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) => _setDialogOpen(false));

    if (_isSoundPlaying) {
      await flutterTts.pause();
      await audioPlayer.pause();
    } else {
      await flutterTts.speak(_imageTexts[index]);
    }
  }

  void _setDialogOpen(bool isOpen) {
    setState(() {
      _isDialogOpen = isOpen;
    });
  }

  Future<void> _toggleSound(int index) async {
    if (_isSoundPlaying) {
      await flutterTts.pause();
      await audioPlayer.pause();
    } else {
      await flutterTts.speak(_imageTexts[index]);
      // await audioPlayer.play("assets/sounds/sound1.mp3");
    }

    setState(() {
      _isSoundPlaying = !_isSoundPlaying;
    });
  }
}

class DelayedWidget extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const DelayedWidget({
    Key? key,
    required this.child,
    required this.delay,
  }) : super(key: key);

  @override
  _DelayedWidgetState createState() => _DelayedWidgetState();
}

class _DelayedWidgetState extends State<DelayedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.delay,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
