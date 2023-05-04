import 'dart:convert';

import '../../../core/utils/constance/strings_manager.dart';

class Validation {
  static String validationMessage(dynamic message) {
    Map<String, dynamic> validationMessageMap = jsonDecode(message.toString());
    String messageError = validationMessageMap.values.first[0].toString();
    String validationMessage;
    print(messageError);
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
    } else {
      validationMessage = "Unexpected Error";
    }
    return validationMessage;
  }

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