import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../core/utils/constance/shared_pref.dart';

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan>
    with SingleTickerProviderStateMixin {
  final List<AssetImage> _images = [
      const AssetImage('assets/images/plan1.png'),
      const AssetImage('assets/images/plan2.png'),
    ];
  final List<AssetImage> _imagesAr = [
    const AssetImage('assets/images/plan1_Ar.png'),
      const AssetImage('assets/images/plan2_Ar.png'),
  ];
  final List<String> _imageTexts = [
    "Firstly, Tunis village"
    "You can start with the village of Tunis, enjoy the picturesque green scenery there, and buy a souvenir of porcelain and pottery, which is widely made in the Tunis Village."
    "Secondly, Rayan Valley"
    "Then you can pass through the wonderful valley of the waterfalls 'Wadi El Rayan' and enjoy the view of the waterfalls and lakes and take memorial photos."
    "Thirdly, whales Valley"
    "And before leaving Wadi El Rayan Reserve, you can pass through Wadi Al Hitan, where you can see the rare and ancient fossils and structures of whales that lived in that area about 40 million years ago."
    "Lastly, Qarun lake"
    "Then you can end this special trip in the charming Lake Qarun, and enjoy the view of the refreshing sea, and also get a meal of delicious seafood, as there are many seafood restaurants there.",

    "Firstly, Qasr Qarun"
    "We will start by exploring the Qasr Qarun, which is a temple from the Greco-Roman era, and it was dedicated to the worship of the god of wine and love among the Romans. As for the name, residents named it this name because it is near Lake Qarun."
    "Secondly, Qasr El Sagha Temple"
    "Then we pass the Qasr Al Sagha Temple, which is an archaeological palace and an ancient Egyptian temple that dates back to the era of the Middle Kingdom and was built of limestone and sand. It is one of the most important historical monuments north of Lake Qarun."
    "Historical City of Madi"
    "Finally, we go to the ancient historical city of Madi, which is an ancient city and includes three temples built by Amenemhet the Third and Amenemhet the Fourth of the Twelfth Dynasty, then additions were added to it in the Roman era, where statues were built with a lion's body and a human head, and it is considered the largest remaining temple from the Middle Kingdom in Egypt",
  ];

final List<String> _imageTextsAr = [
    "أولا, قرية تونس"
    "يمكنك البدء بقرية تونس، والاستمتاع بالمناظر الخضراء الخلابة هناك، وشراء تذكار من الخزف والفخار، والذي يتم صنعه على نطاق واسع في قرية تونس."
    "ثانيا, وادي الريان"
    "ثم يمكنك الذهاب الى وادي الشلالات الرائع 'وادي الريان' والاستمتاع بمنظر الشلالات والبحيرات والتقاط الصور التذكارية."
    "ثالثا, وادي الحيتان"
    "وقبل أن تغادر محمية وادي الريان، يمكنك المرور عبر وادي الحيتان، وهناك يمكنك مشاهدة الأحافير النادرة والقديمة وهياكل الحيتان التي عاشت في تلك المنطقة منذ حوالي 40 مليون سنة."
    "وأخيرا, بحيرة قارون"
    "يمكنك ختم هذه الرحلة المميزة في بحيرة قارون الساحرة، والاستمتاع بمنظر البحر المنعش، وكذلك تناول وجبة من المأكولات البحرية اللذيذة، حيث يوجد العديد من مطاعم المأكولات البحرية هناك.",
    
    "أولا, قصر قارون"
    "سنبدأ باستكشاف قصر قارون، وهو معبد من العصر اليوناني الروماني، وكان مخصصًا لعبادة إله النبيذ والحب بين الرومان. أما عن الاسم فقد أطلق عليه السكان هذا الاسم لأنه قريب من بحيرة قارون."
    "ثانيا, قصر معبد الصاغة"
    "ثم نمر بمعبد قصر الصاغة وهو قصر أثري ومعبد مصري قديم يعود إلى عصر الدولة الوسطى وتم بناؤه من الحجر الجيري والرمل. وهو من أهم المعالم التاريخية في شمال بحيرة قارون."
    "وأخيرا, مدينة ماضي التاريخية"
    "أخيرًا نذهب إلى مدينة ماضي التاريخية القديمة وهي مدينة قديمة وتضم ثلاثة معابد بناها أمنمحات الثالث وأمنمحات الرابع من الأسرة الثانية عشر، ثم أضيفت إليها إضافات في العصر الروماني حيث شيدت تماثيل بجسم أسد ورأس بشري، ويعتبر أكبر معبد متبقي من الدولة الوسطى في مصر",
  ];

  bool _isDialogOpen = false;
  bool _soundPlaying = false;

  //FlutterTts flutterTts = FlutterTts();
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    
    //flutterTts.setSpeechRate(0.4);
  }

  @override
  void dispose() {
    super.dispose();
    //flutterTts.stop();
    audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            // Background image
            // Container(
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage("assets/images/e1.jpg"),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),

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
      );
  }

  List<Widget> _buildImageWidgets() {
    List<Widget> widgets = [];
    int len = sharedPreferences!.getString("Language") == "AR" ? _imagesAr.length : _images.length;
    for (int i = 0; i < len; i++) {
      widgets.add(
        Padding(
          padding:
              const EdgeInsets.only(top: 25, bottom: 25, left: 40, right: 40),
          child: GestureDetector(
            onTap: () {
              _soundPlaying = true;
              _showImageDialog(i);
              
            },
            child: Hero(
              tag: "image$i",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image(
                  image: sharedPreferences!.getString("Language") == "AR" ? _imagesAr[i] : _images[i],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      );

      if (i < len - 1) {
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

    widgets.add(const SizedBox(height: 50,));

    return widgets;
  }

  Future<void> _showImageDialog(int index) async {
    _setDialogOpen(true);

    showDialog(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder:(context,setState) => Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Hero(
                tag: "image$index",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: sharedPreferences!.getString("Language") == "AR" ? _imagesAr[index] : _images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 16.0,
                right: 16.0,
                child: GestureDetector(
                  onTap: () async{
                  
                  if(_soundPlaying)
                  {
                    setState(() {
                      _soundPlaying = false;
                    });
                    //flutterTts.pause();
                    audioPlayer.pause();
                  }
                  else{
                    setState(() {
                      _soundPlaying = true;
                    });
                    
                    //await flutterTts.speak(sharedPreferences!.getString("Language") == "AR" ? _imageTextsAr[index] : _imageTexts[index]);
                    if(index == 0)
                    {
                      await audioPlayer.play(AssetSource(sharedPreferences!.getString("Language") == "AR" ? 'images/plan1ArSound.mp3' : 'images/plan1Sound.mp3'));
                    }
                    else if (index == 1)
                    {
                      await audioPlayer.play(AssetSource(sharedPreferences!.getString("Language") == "AR" ? 'images/plan2ArSound.mp3' : 'images/plan2Sound.mp3'));
                    }
                    
                  }
                  },
                  child:  Icon(_soundPlaying ? Icons.volume_up :Icons.volume_off,color: Colors.white,size: 32.0,)
                ),
              ),

              Positioned(
                top: 16.0,
                left: 16.0,
                child: InkWell(
                  onTap: () async {
                    if(_soundPlaying)
                    {
                    //flutterTts.stop();
                    audioPlayer.seek(Duration.zero);
                    //await flutterTts.speak(sharedPreferences!.getString("Language") == "AR" ? _imageTextsAr[index] : _imageTexts[index]);
                    // if(index == 0)
                    // {
                    //   await audioPlayer.play(AssetSource(sharedPreferences!.getString("Language") == "AR" ? 'images/plan1ArSound.mp3' : 'images/plan1Sound.mp3'));
                    // }
                    // else if (index == 1)
                    // {
                    //   await audioPlayer.play(AssetSource(sharedPreferences!.getString("Language") == "AR" ? 'images/plan2ArSound.mp3' : 'images/plan2Sound.mp3'));
                    // }
                    }
                  },
                  child: const Icon(
                    Icons.repeat,
                    color: Colors.white,
                    size: 32.0,
                  ),
                ),
              ),
            ],
          ),
        )
      )
    ).then((_) => _setDialogOpen(false)
    );

    //await flutterTts.speak(sharedPreferences!.getString("Language") == "AR" ? _imageTextsAr[index] : _imageTexts[index]);
    if(index == 0)
    {
      await audioPlayer.play(AssetSource(sharedPreferences!.getString("Language") == "AR" ? 'images/plan1ArSound.mp3' : 'images/plan1Sound.mp3'));
    }
    else if (index == 1)
    {
      await audioPlayer.play(AssetSource(sharedPreferences!.getString("Language") == "AR" ? 'images/plan2ArSound.mp3' : 'images/plan2Sound.mp3'));
    }
  }

  void _setDialogOpen(bool isOpen) {
    setState(() {
      if(!isOpen )
      {
        //flutterTts.stop();
        audioPlayer.stop();
      }
      _isDialogOpen = isOpen;
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
