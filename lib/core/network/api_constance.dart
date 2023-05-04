class ApiConstance {
  // BaseUrl
  static const String baseUrl =
      "http://faytourapp.pythonanywhere.com"; //"http://10.0.2.2:8000";

/* **************** Access Token **************** */
  static const String KeyAccessToken = "KeyAccessToken";

/* **************** Hotels EndPoints **************** */
  // GET POST PUT DEL Hotel , GET By ID
  static const String hotelPath = "$baseUrl/api/Hotel/";

/* **************** Hotels EndPoints **************** */
  // GET All Hotel Rate , GET By IDs , POST PUT Hotel Rate
  static const String hotelRatePath = "$baseUrl/api/RateHotel/";

/* **************** User EndPoints **************** */
  static const String userDetailsPath = "$baseUrl/rest-auth/user/";
  static const String registrationPath = "$baseUrl/rest-auth/registration/";
  static const String logInPath = "$baseUrl/rest-auth/login/";
  static const String logoutPath = "$baseUrl/rest-auth/logout/";
  static const String changePasswordPath =
      "$baseUrl/rest-auth/password/change/";
  static const String resetPasswordPath = "$baseUrl/password-reset/";
}
