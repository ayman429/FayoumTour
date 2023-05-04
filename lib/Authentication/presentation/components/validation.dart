import 'dart:convert';

class Validation {
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
  static String validationMessage(dynamic message) {
    Map<String, dynamic> validationMessageMap = jsonDecode(message.toString());
    // if (validationMessageMap.keys.contains("username")) {
    //   return validationMessageMap["username"].toString();
    // } else if (validationMessageMap.keys.contains("email")) {
    //   return validationMessageMap["email"].toString();
    // } else if (validationMessageMap.keys.contains("password1")) {
    //   return validationMessageMap["password1"].toString();
    // } else if (validationMessageMap.keys.contains("password2")) {
    //   return validationMessageMap["password2"].toString();
    // } else if (validationMessageMap.keys.contains("non_field_errors")) {
    //   return validationMessageMap["non_field_errors"].toString();
    // } else {
    //   return validationMessageMap.values.first.toString();
    // }
    return validationMessageMap.values.first[0].toString();
  }
}
// Map<String, dynamic> map = jsonDecode(l.message.toString());
        // print(map.keys.contains("username"));