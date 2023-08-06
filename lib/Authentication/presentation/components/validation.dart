import 'dart:convert';

import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/constance/strings_manager.dart';

class Validation {
  static String validationMessage(dynamic message) {
    message = message.toString();

    if (message != "null") {
      Map<String, dynamic> validationMessageMap =
          jsonDecode(message.toString());
      String messageError = validationMessageMap.values.first[0].toString();
      //print("Unexpected Error");
      print(messageError);
      String validationMessage;
      // print(messageError);
      if (messageError == AppStrings.apiEmptyString1 ||
          messageError.contains(AppStrings.apiEmptyString2)) {
        validationMessage = sharedPreferences!.getString("Language") == "AR"
            ? "يجب ملئ الفراعات."
            : AppStrings.messageEmptyString;
      } else if (messageError == AppStrings.emailError) {
        validationMessage = sharedPreferences!.getString("Language") == "AR"
            ? "تجب كتابة اميل صالح."
            : AppStrings.emailError;
      } else if (messageError.contains(AppStrings.apiCredentials)) {
        validationMessage = sharedPreferences!.getString("Language") == "AR"
            ? "الايميل او كلمة المرور خاطئ."
            : AppStrings.messageCredentials;
      } else if (messageError == AppStrings.passwordLenError) {
        validationMessage = sharedPreferences!.getString("Language") == "AR"
            ? "كلمة المرور هذه قصيرة جدًا. يجب ألا تقل عن 8 أحرف."
            : AppStrings.passwordLenError;
      } else if (messageError == AppStrings.passwordMatchedError) {
        validationMessage = sharedPreferences!.getString("Language") == "AR"
            ? "كلمة المرور غير متطابقة."
            : AppStrings.passwordMatchedError;
      } else if (messageError == AppStrings.passwordCommonError) {
        validationMessage = sharedPreferences!.getString("Language") == "AR"
            ? "كلمة المرور هذه شائعة جدًا."
            : AppStrings.passwordCommonError;
      } else if (messageError == AppStrings.usernameExists ||
          messageError == AppStrings.customUserExists) {
        validationMessage = sharedPreferences!.getString("Language") == "AR"
            ? "هذا الاسم مستخدم."
            : AppStrings.usernameExists;
      } else if (messageError == AppStrings.passwordSimilar) {
        validationMessage = sharedPreferences!.getString("Language") == "AR"
            ? "كلمة المرور مشابهة جدًا لعنوان البريد الإلكتروني."
            : AppStrings.passwordSimilar;
      } else {
        //print("Unexpected Error");
        //print(messageError);
        validationMessage = sharedPreferences!.getString("Language") == "AR"
            ? "حدثت مشكلة حاول مرة اخري."
            : "problem happened try again";
      }
      return validationMessage;
    }
    return sharedPreferences!.getString("Language") == "AR"
        ? "حدثت مشكلة حاول مرة اخري."
        : "problem happened try again";
  }
/*{"new_password2":["This password is too short. It must contain at least 8 characters.",
"This password is too common.","This password is entirely numeric."]} */

//"This password is too common.","This password is entirely numeric."

  // static Map<String, dynamic> loginValidationMessage(dynamic message) {
  //   Map<String, dynamic> validationMessageMap = jsonDecode(message.toString());
  //   Map<String, dynamic> validationMessageError = {
  //     "email": "",
  //     "password": "",
  //     "non_field_errors": "",
  //     "unexpected": ""
  //   };
  //   if (validationMessageMap.keys.contains("email")) {
  //     validationMessageError["email"] =
  //         validationMessageMap["email"].toString();
  //   } else if (validationMessageMap.keys.contains("password")) {
  //     validationMessageError["password"] =
  //         validationMessageMap["password"].toString();
  //   } else if (validationMessageMap.keys.contains("non_field_errors")) {
  //     validationMessageError["non_field_errors"] =
  //         validationMessageMap["non_field_errors"].toString();
  //   } else {
  //     validationMessageError["unexpected"] = "Unexpected Error";
  //     //validationMessageMap.values.first.toString();
  //   }
  //   // return validationMessageMap.values.first[0].toString();
  //   return validationMessageError;
  // }
}
// Map<String, dynamic> map = jsonDecode(l.message.toString());
        // print(map.keys.contains("username"));

  // static String validationMessage(String message) {
  //   String validationMessage;
  //   if (message == AppStrings.apiEmptyString1 ||
  //       message.contains(AppStrings.apiEmptyString2)) {
  //     validationMessage = AppStrings.messageEmptyString;
  //   } else if (message == AppStrings.emailError) {
  //     validationMessage = AppStrings.emailError;
  //   } else if (message.contains(AppStrings.apiCredentials)) {
  //     validationMessage = AppStrings.messageCredentials;
  //   } else {
  //     validationMessage = message;
  //   }
  //   return validationMessage;
  // }
// registrationValidationMessage