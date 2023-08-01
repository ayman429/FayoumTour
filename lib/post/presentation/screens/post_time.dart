import 'package:intl/intl.dart';

import '../../../core/utils/constance/shared_pref.dart';

String PostTime(String postTime) {
  DateTime now = DateTime.now();
  String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

  String addDate;
  String addTime;

  int addYear;
  int addMonth;
  int addDay;
  int addHour;
  int addMinute;
  // String addSecond;

  String currentDate;
  String currentTime;
  int currentYear;
  int currentMonth;
  int currentDay;
  int currentHour;
  int currentMinute;
  // String currentSecond;
  /******* Add Date Time *******/
  addDate = postTime.split(" ")[0];
  addTime = postTime.split(" ")[1];

  addYear = int.parse(addDate.split("-")[0]);
  addMonth = int.parse(addDate.split("-")[1]);
  addDay = int.parse(addDate.split("-")[2]);

  addHour = int.parse(addTime.split(":")[0]);
  addMinute = int.parse(addTime.split(":")[1]);
  // addSecond = addTime.split(":")[2];

  /******* Current Date Time *******/
  currentDate = formattedTime.split(" ")[0];
  currentTime = formattedTime.split(" ")[1];

  currentYear = int.parse(currentDate.split("-")[0]);
  currentMonth = int.parse(currentDate.split("-")[1]);
  currentDay = int.parse(currentDate.split("-")[2]);

  currentHour = int.parse(currentTime.split(":")[0]);
  currentMinute = int.parse(currentTime.split(":")[1]);
  // currentSecond = formattedTime.split(":")[2];

  // print(postTime.substring(0, 16));
  if (postTime.substring(0, 16) == formattedTime.substring(0, 16)) {
    return sharedPreferences!.getString("Language") == "AR" ? "الان" : "Now";
  } else {
    if (addDate == currentDate) {
      if (addHour == currentHour) {
        if (addMinute == currentMinute) {
        } else {
          return sharedPreferences!.getString("Language") == "AR"
              ? "${currentMinute - addMinute} د"
              : "${currentMinute - addMinute} Minute";
        }
      } else {
        if (addMinute > currentMinute) {
          if (currentHour - addHour == 1) {
            return sharedPreferences!.getString("Language") == "AR"
                ? "${60 - (addMinute - currentMinute)} د"
                : "${60 - (addMinute - currentMinute)} Minute";
          } else {
            return sharedPreferences!.getString("Language") == "AR"
                ? "${(currentHour - addHour) - 1} س"
                : "${(currentHour - addHour) - 1} Hour";
          }
        } else {
          return sharedPreferences!.getString("Language") == "AR"
              ? "${currentHour - addHour} س"
              : "${currentHour - addHour} Hour";
        }
      }
    } else {
      return "$addDay/$addMonth/$addYear";
    }
  }
  return "";
}
