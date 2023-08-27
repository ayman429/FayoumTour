// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../core/utils/app_localizations.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
          AppLocalizations.of(context)!.translate("About FayTour"),
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
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: sharedPreferences!.getString("Language") == "AR"
                      ? const EdgeInsets.only(top: 35)
                      : const EdgeInsets.only(),
                      child: Text(
                        AppLocalizations.of(context)!.translate("info paragraph1"),
                        style: sharedPreferences!.getString("Language") == "AR"
                        ?  TextStyle(
                          fontFamily: "readPro",
                          height: 1.65, fontSize: (16/360)*MediaQuery.of(context).size.width,//16,
                          fontWeight: FontWeight.bold
                          )
                        :  TextStyle(
                          fontFamily: "domine",
                          height: 1.50, fontSize: (16/360)*MediaQuery.of(context).size.width,//16
                          ),
                      ),
                    ),
                  ),
                  Expanded(child: Image.asset(AppStrings.logoImage,)),
                ],
              ),
              Text(
                AppLocalizations.of(context)!.translate("info paragraph2"),
                style: sharedPreferences!.getString("Language") == "AR"
                      ?  TextStyle(
                        fontFamily: "readPro",
                        height: 1.65, fontSize: (16/360)*MediaQuery.of(context).size.width,//16,
                        fontWeight: FontWeight.bold
                        )
                      :  TextStyle(
                        fontFamily: "domine",
                        height: 1.50, fontSize: (16/360)*MediaQuery.of(context).size.width,//16
                        ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/grad.png",
                    height: (120/772)*MediaQuery.of(context).size.height,//120,
                    width: (120/360)*MediaQuery.of(context).size.width,//120,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  Image.asset(
                    "assets/images/tour.png",
                    height: (120/772)*MediaQuery.of(context).size.height,//120,
                    width: (120/360)*MediaQuery.of(context).size.width,//120,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.translate("info paragraph3"),
                style: sharedPreferences!.getString("Language") == "AR"
                      ?  TextStyle(
                        fontFamily: "readPro",
                        height: 1.65, fontSize: (16/360)*MediaQuery.of(context).size.width,//16,
                        fontWeight: FontWeight.bold
                        )
                      :  TextStyle(
                        fontFamily: "domine",
                        height: 1.50, fontSize: (16/360)*MediaQuery.of(context).size.width,//16
                        ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.translate("Cooperation with"),
                  style: sharedPreferences!.getString("Language") == "AR"
                  ?  TextStyle(
                    fontFamily: "ibmP",
                      fontSize: (28/360)*MediaQuery.of(context).size.width,//28,
                      fontWeight: FontWeight.bold)
                  :  TextStyle(
                    fontFamily: "acme",
                      fontSize: (25/360)*MediaQuery.of(context).size.width,//25,
                      fontWeight: FontWeight.bold, ),
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
                  children:  [
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/fayoum_gov.jpg'),
                      radius: 30,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Text(AppLocalizations.of(context)!.translate("Fayoum Governorate Administration"),
                            style: sharedPreferences!.getString("Language") == "AR"
                                ?  TextStyle(
                                fontSize: (23/360)*MediaQuery.of(context).size.width,//23,
                                fontFamily: "galaxy")
                                :  TextStyle(
                                fontSize: (15/360)*MediaQuery.of(context).size.width,//15,
                                fontWeight: FontWeight.bold),
                                
                                )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.translate("Supervised by"),
                  style: sharedPreferences!.getString("Language") == "AR"
                  ?  TextStyle(
                    fontFamily: "ibmP",
                      fontSize: (28/360)*MediaQuery.of(context).size.width,//28,
                      fontWeight: FontWeight.bold)
                  :  TextStyle(
                    fontFamily: "acme",
                      fontSize: (25/360)*MediaQuery.of(context).size.width,//25,
                      fontWeight: FontWeight.bold, ),
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
                        children:  [
                          Text(
                            AppLocalizations.of(context)!.translate("Dr. Ahmed Slama"),
                            style: sharedPreferences!.getString("Language") == "AR"
                                ?  TextStyle(
                                fontSize: (23/360)*MediaQuery.of(context).size.width,//23,
                                fontFamily: "galaxy")
                                :  TextStyle(
                                fontSize: (17/360)*MediaQuery.of(context).size.width,//17,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                              AppLocalizations.of(context)!.translate("Slama Desc"),
                              style:
                                  TextStyle(fontSize: (12/360)*MediaQuery.of(context).size.width,//12,
                                  color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.translate("Developed by"),
                  style: sharedPreferences!.getString("Language") == "AR"
                  ?  TextStyle(
                    fontFamily: "ibmP",
                      fontSize: (28/360)*MediaQuery.of(context).size.width,//28,
                      fontWeight: FontWeight.bold )
                  :  TextStyle(
                    fontFamily: "acme",
                      fontSize: (25/360)*MediaQuery.of(context).size.width,//25,
                      fontWeight: FontWeight.bold, ),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                child: sharedPreferences!.getString("Language") == "AR"
                                ? Text(
                                      "${AppLocalizations.of(context)!.translate("Eng.")}${AppLocalizations.of(context)!.translate("Ayman Mansour")}",
                                      style:  TextStyle(
                                fontSize: (23/360)*MediaQuery.of(context).size.width,//23,
                                fontFamily: "galaxy"),
                                    )
                                : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    Text(
                                      AppLocalizations.of(context)!.translate("Eng."),
                                      style:  TextStyle(fontSize: (14/360)*MediaQuery.of(context).size.width,//14
                                      ),
                                    ),
                                    Text(AppLocalizations.of(context)!.translate("Ayman Mansour"),
                                        style:  TextStyle(
                                            fontSize: (15/360)*MediaQuery.of(context).size.width,//15,
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
                                child: sharedPreferences!.getString("Language") == "AR"
                                ? Text(
                                      "${AppLocalizations.of(context)!.translate("Eng.")}${AppLocalizations.of(context)!.translate("Marwan Yasser")}",
                                      style:  TextStyle(
                                fontSize: (23/360)*MediaQuery.of(context).size.width,//23,
                                fontFamily: "galaxy"),
                                    )
                                : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    Text(
                                      AppLocalizations.of(context)!.translate("Eng."),
                                      style:  TextStyle(fontSize: (14/360)*MediaQuery.of(context).size.width,//14
                                      ),
                                    ),
                                    Text(AppLocalizations.of(context)!.translate("Marwan Yasser"),
                                        style:  TextStyle(
                                            fontSize: (15/360)*MediaQuery.of(context).size.width,//15,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                child: sharedPreferences!.getString("Language") == "AR"
                                ? Text(
                                      "${AppLocalizations.of(context)!.translate("Eng.")}${AppLocalizations.of(context)!.translate("Mahmoud Hamdy")}",
                                      style:  TextStyle(
                                fontSize: (23/360)*MediaQuery.of(context).size.width,//23,
                                fontFamily: "galaxy"),
                                    )
                                : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    Text(
                                      AppLocalizations.of(context)!.translate("Eng."),
                                      style:  TextStyle(fontSize: (14/360)*MediaQuery.of(context).size.width,//14
                                      ),
                                    ),
                                    Text(AppLocalizations.of(context)!.translate("Mahmoud Hamdy"),
                                        style:  TextStyle(
                                            fontSize: (15/360)*MediaQuery.of(context).size.width,//15,
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
                                child: sharedPreferences!.getString("Language") == "AR"
                                ? Text(
                                      "${AppLocalizations.of(context)!.translate("Eng.")}${AppLocalizations.of(context)!.translate("Hamada Mostafa")}",
                                      style:  TextStyle(
                                fontSize: (23/360)*MediaQuery.of(context).size.width,//23,
                                fontFamily: "galaxy"),
                                    )
                                : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    Text(
                                      AppLocalizations.of(context)!.translate("Eng."),
                                      style:  TextStyle(fontSize: (14/360)*MediaQuery.of(context).size.width,//14
                                      ),
                                    ),
                                    Text(AppLocalizations.of(context)!.translate("Hamada Mostafa"),
                                        style:  TextStyle(
                                            fontSize: (15/360)*MediaQuery.of(context).size.width,//15,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                child: sharedPreferences!.getString("Language") == "AR"
                                ? Text(
                                      "${AppLocalizations.of(context)!.translate("Eng.")}${AppLocalizations.of(context)!.translate("Ahmed Abdelaltawab")}",
                                      style:  TextStyle(
                                fontSize: (23/360)*MediaQuery.of(context).size.width,//23,
                                fontFamily: "galaxy"),
                                    )
                                : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    Text(
                                      AppLocalizations.of(context)!.translate("Eng."),
                                      style:  TextStyle(fontSize: (13/360)*MediaQuery.of(context).size.width,//13
                                      ),
                                    ),
                                    Text(AppLocalizations.of(context)!.translate("Ahmed Abdelaltawab"),
                                        style:  TextStyle(
                                            fontSize: (15/360)*MediaQuery.of(context).size.width,//15,
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
                                child: sharedPreferences!.getString("Language") == "AR"
                                ? Text(
                                      "${AppLocalizations.of(context)!.translate("Eng.")}${AppLocalizations.of(context)!.translate("Mohammed Ramadan")}",
                                      style:  TextStyle(
                                fontSize: (23/360)*MediaQuery.of(context).size.width,//23,
                                fontFamily: "galaxy"),
                                    )
                                : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    Text(
                                      AppLocalizations.of(context)!.translate("Eng."),
                                      style:  TextStyle(fontSize: (14/360)*MediaQuery.of(context).size.width,//14
                                      ),
                                    ),
                                    Text(AppLocalizations.of(context)!.translate("Mohammed Ramadan"),
                                        style:  TextStyle(
                                            fontSize: (15/360)*MediaQuery.of(context).size.width,//15,
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
                children:  [
                  Padding(
                    padding: sharedPreferences!.getString("Language") == "AR"
                    ?  const EdgeInsets.only(bottom: 0)
                    : const EdgeInsets.only(bottom: 0),
                    child: const Icon(
                      Icons.copyright_outlined,
                      size: 17,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    AppLocalizations.of(context)!.translate("CopyRights"),
                    style:  TextStyle(fontSize: (16/360)*MediaQuery.of(context).size.width,//16,
                    fontFamily: "readPro"),
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
