import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/constance/strings_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'About FayTour',
          style: TextStyle(
              fontFamily: AppStrings.fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Our Greetings and foremost, we sincerely hope that the application has successfully garnered your utmost satisfaction.\n",
                      style: GoogleFonts.domine(height: 1.45, fontSize: 16),
                    ),
                  ),
                  Expanded(child: Image.asset(AppStrings.logoImage)),
                ],
              ),
              Text(
                "Allow us to elucidate that this application was conceived as the graduation project at the Faculty of Computer Science. "
                "It served as a magnificent culmination of our academic journey. The underlying concept behind this app "
                "revolved around amalgamating all the splendid tourist destinations nestled within the embrace of Fayoum Governorate in the land of Egypt. "
                "Our primary objective was to acquaint visitors and all people with these extraordinary locales while also streamlining their accessibility.\n",
                style: GoogleFonts.domine(height: 1.45, fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/grad.png",
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  Image.asset(
                    "assets/images/tour.png",
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Unquestionably, our ardent aspiration was to invigorate the realm of tourism in this enchanting region. "
                "Our choice to embark upon this venture was primarily inspired by the focus on numerous untapped and abandoned tourist havens "
                "that yearned for rejuvenation. It also became apparent that the custodians entrusted with developing and preserving this remarkable "
                "expanse were in dire need of a dynamic mobile application for tourists. Such a platform would undoubtedly serve as an indispensable tool "
                "for disseminating captivating advertisements and diligently promoting the vast potential for tourism within this resplendent domain.",
                style: GoogleFonts.domine(height: 1.45, fontSize: 16),
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'Cooperation with:',
                  style: GoogleFonts.acme(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  const url = "http://www.fayoum.gov.eg/film/default.aspx";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/fayoum_gov.jpg'),
                      radius: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Text("Fayoum Governorate Administration",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/m1.jpg'),
                          radius: 30,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Dr. Moataz Ahmed",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                              Text("Director of Fayoum Tourism Authority",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/m2.jpg'),
                          radius: 30,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Mr. Mahmoud Kamel",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                              Text("Researcher at Fayoum Tourism Authority",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'Supervised by:',
                  style: GoogleFonts.acme(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  const url = "https://www.facebook.com/Ahmed.Slama12";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/slama.jpg'),
                      radius: 30,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Dr. Ahmed Slama",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                              "Doctor at the Faculty of Computers and Artificial Intelligence, Fayoum University",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'Developed by:',
                  style: GoogleFonts.acme(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            const url =
                                "https://www.facebook.com/profile.php?id=100004426397969";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/ayman.jpg'),
                                radius: 30,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Eng.",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text("Ayman Mansour",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            const url =
                                "https://www.facebook.com/marwanyasser632001/";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/marwan.jpg'),
                                radius: 30,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Eng.",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text("Marwan Yasser",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            const url =
                                "https://www.facebook.com/profile.php?id=100010258625338";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/mahmoud.jpg'),
                                radius: 30,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Eng.",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text("Mahmoud Hamdy",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            const url =
                                "https://www.facebook.com/profile.php?id=100010453833581";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/hamada.jpg'),
                                radius: 30,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Eng.",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text("Hamada Mostafa",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            const url = "https://www.facebook.com/ahmed.eteka";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/ahmed.jpg'),
                                radius: 30,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Eng.",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Text("Ahmed Abdelaltawab",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            const url =
                                "https://www.facebook.com/profile.php?id=100011939985594";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/mohammed.jpg'),
                                radius: 30,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Eng.",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text("Mohammed Ramadan",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.copyright_outlined,
                    size: 15,
                  ),
                  SizedBox(width: 2),
                  Text(
                    '2023',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'FayTour . All rights reserved.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
