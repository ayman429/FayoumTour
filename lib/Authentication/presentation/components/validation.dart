import 'dart:convert';

import '../../../core/utils/constance/strings_manager.dart';

class Validation {
  static String validationMessage(dynamic message) {
    message = message.toString();
    print(message);
    if (message != "null") {
      Map<String, dynamic> validationMessageMap =
          jsonDecode(message.toString());
      String messageError = validationMessageMap.values.first[0].toString();
      print("Unexpected Error");
      print(messageError);
      String validationMessage;
      // print(messageError);
      if (messageError == AppStrings.apiEmptyString1 ||
          messageError.contains(AppStrings.apiEmptyString2)) {
        validationMessage = AppStrings.messageEmptyString;
      } else if (messageError == AppStrings.emailError) {
        validationMessage = AppStrings.emailError;
      } else if (messageError.contains(AppStrings.apiCredentials)) {
        validationMessage = AppStrings.messageCredentials;
      } else if (messageError == AppStrings.passwordLenError) {
        validationMessage = AppStrings.passwordLenError;
      } else if (messageError == AppStrings.passwordMatchedError) {
        validationMessage = AppStrings.passwordMatchedError;
      } else if (messageError == AppStrings.passwordCommonError) {
        validationMessage = AppStrings.passwordCommonError;
      } else if (messageError == AppStrings.usernameExists ||
          messageError == AppStrings.customUserExists) {
        validationMessage = AppStrings.usernameExists;
      } else if (messageError == AppStrings.passwordSimilar) {
        validationMessage = AppStrings.passwordSimilar;
      } else {
        print("Unexpected Error");
        print(messageError);
        validationMessage = "Unexpected Error";
      }
      return validationMessage;
    }
    return "problem happened try again";
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