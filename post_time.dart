// import 'package:intl/intl.dart';

// String PostTime(String postTime) {
//   DateTime now = DateTime.now();
//   String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

//   String addDate;
//   String addTime;

//   int addYear;
//   int addMonth;
//   int addDay;
//   int addHour;
//   int addMinute;
//   // String addSecond;

//   String currentDate;
//   String currentTime;
//   int currentYear;
//   int currentMonth;
//   int currentDay;
//   int currentHour;
//   int currentMinute;
//   // String currentSecond;
//   /******* Add Date Time *******/
//   addDate = postTime.split(" ")[0];
//   addTime = postTime.split(" ")[1];

//   addYear = int.parse(addDate.split("-")[0]);
//   addMonth = int.parse(addDate.split("-")[1]);
//   addDay = int.parse(addDate.split("-")[2]);

//   addHour = int.parse(addTime.split(":")[0]);
//   addMinute = int.parse(addTime.split(":")[1]);
//   // addSecond = addTime.split(":")[2];

//   /******* Current Date Time *******/
//   currentDate = formattedTime.split(" ")[0];
//   currentTime = formattedTime.split(" ")[1];

//   currentYear = int.parse(currentDate.split("-")[0]);
//   currentMonth = int.parse(currentDate.split("-")[1]);
//   currentDay = int.parse(currentDate.split("-")[2]);

//   currentHour = int.parse(currentTime.split(":")[0]);
//   currentMinute = int.parse(currentTime.split(":")[1]);
//   // currentSecond = formattedTime.split(":")[2];

//   // print(postTime.substring(0, 16));
//   if (postTime.substring(0, 16) == formattedTime.substring(0, 16)) {
//     return "Now";
//   } else {
//     if (addDate == currentDate) {
//       if (addHour == currentHour) {
//         if (addMinute == currentMinute) {
//         } else {
//           return "${currentMinute - addMinute} Minute";
//         }
//       } else {
//         if (addMinute > currentMinute) {
//           if (currentHour - addHour == 1) {
//             return "${60 - (addMinute - currentMinute)} Minute";
//           } else {
//             return "${(currentHour - addHour) - 1} Hour";
//           }
//         } else {
//           return "${currentHour - addHour} Hour";
//         }
//       }
//     } else {
//       return "$addDay/$addMonth/$addYear";
//     }
//   }
//   return "";
// }

// void main() {
//   // String postTime = "2023-08-01 04:21:23";
//   String postTime = "2023-07-31 23:59:23";
//   print(PostTime(postTime));
// }

// import 'package:intl/intl.dart';

// void main() {
//   String requestTime = "2023-08-01 16:17:23";
//   DateTime parsedRequestTime = DateTime.parse(requestTime);

//   DateTime now = DateTime.now();
//   Duration difference = now.difference(parsedRequestTime);

//   String timeAgo = getTimeAgo(difference, parsedRequestTime);

//   print("Time ago: $timeAgo");
// }

// String getTimeAgo(Duration difference, DateTime parsedRequestTime) {
//   if (difference.inSeconds < 60) {
//     // return sharedPreferences!.getString("Language") == "AR" ? "الان" : "Now";
//     return "${difference.inSeconds} seconds ago";
//   } else if (difference.inMinutes < 60) {
//     // return sharedPreferences!.getString("Language") == "AR"
//     //     ? "${difference.inMinutes}  د"
//     //     : "${difference.inMinutes} minutes";
//     return "${difference.inMinutes} minutes ago";
//   } else if (difference.inHours < 24) {
//     // return sharedPreferences!.getString("Language") == "AR"
//     // ? "${difference.inHours} س"
//     // : "${difference.inHours} hours";
//     return "${difference.inHours} hours ago";
//   } else if (difference.inDays < 30) {
//     // return sharedPreferences!.getString("Language") == "AR"
//     // ? "${difference.inDays} ي"
//     // : "${difference.inDays} days";
//     return "${difference.inDays} days ago";
//   } else if (difference.inDays < 365) {
//     int months = difference.inDays ~/ 30;
//     return parsedRequestTime.toString().substring(0, 16);
//     // return "${months} months ago";
//   } else {
//     int years = difference.inDays ~/ 365;
//     return parsedRequestTime.toString().substring(0, 16);
//     // return "${years} years ago";
//   }
// }

////////////////////

void main() {
  String postTime = "";
  // String postTime = "2023-07-31 23:59:23";
  print(isEnglish(postTime[0]));
}

bool isEnglish(String input) {
  print(input);
  for (var codePoint in input.codeUnits) {
    // English Unicode range: 0020 - 007E (basic Latin characters)
    if (codePoint >= 0x0020 && codePoint <= 0x007E) {
      return true;
    }
  }
  return false;
}

// String PostTime(String requestTime) {
//   DateTime parsedRequestTime = DateTime.parse(requestTime);
//   DateTime now = DateTime.now();
//   Duration difference = now.difference(parsedRequestTime);
//   print(difference.inSeconds);
//   if (difference.inSeconds < 60) {
//     print("/////////////////////////////////");
//     // return sharedPreferences!.getString("Language") == "AR" ? "الان" : "Now";
//     return "${difference.inSeconds} seconds ago";
//   } else if (difference.inMinutes < 60) {
//     print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
//     // return sharedPreferences!.getString("Language") == "AR"
//     //     ? "${difference.inMinutes}  د"
//     //     : "${difference.inMinutes} minutes";
//     return "${difference.inMinutes} minutes ago";
//   } else if (difference.inHours < 24) {
//     // return sharedPreferences!.getString("Language") == "AR"
//     //     ? "${difference.inHours} س"
//     //     : "${difference.inHours} hours";
//     return "${difference.inHours} hours ago";
//   } else if (difference.inDays < 30) {
//     // return sharedPreferences!.getString("Language") == "AR"
//     //     ? "${difference.inDays} ي"
//     //     : "${difference.inDays} days";
//     return "${difference.inDays} days ago";
//   } else if (difference.inDays < 365) {
//     int months = difference.inDays ~/ 30;
//     return parsedRequestTime.toString().substring(0, 16);
//     // return "${months} months ago";
//   } else {
//     int years = difference.inDays ~/ 365;
//     return parsedRequestTime.toString().substring(0, 16);
//     // return "${years} years ago";
//   }
// }
