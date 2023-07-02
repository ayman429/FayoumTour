class ApiConstance {
  // BaseUrl
  static const String baseUrl =
      "https://faytourapp.pythonanywhere.com"; //"http://10.0.2.2:8000";

/* **************** Access Token **************** */
  static const String KeyAccessToken = "KeyAccessToken";

/* **************** Hotel/TourismPlac EndPoints **************** */
  // GET POST PUT DEL Hotel/TourismPlace , GET By ID
  static const String hotelPath = "$baseUrl/api/Hotel/";
  static const String tourismPlacePath = "$baseUrl/api/TourismPlace/";
  static const String model1Path = "$baseUrl/api/TourismPlace/model1/";

  /* **************** HotelReservation EndPoints **************** */
  // GET POST PUT DEL HotelReservation
  static const String hotelReservationPath = "$baseUrl/api/HotelReservation/";
  static const String getHotelReservationPath =
      "$baseUrl/api/HotelReservation/getHotelReservation/";
  static const String getHotelReservationByUserPath =
      "$baseUrl/api/HotelReservation/getHotelReservationByUser/";

/* **************** Rates EndPoints **************** */
  // GET All Hotel/TourismPlace Rate , GET By IDs , POST PUT Hotel Rate
  static const String hotelRatePath = "$baseUrl/api/RateHotel/";
  static const String tourismPlaceRatePath = "$baseUrl/api/RateTourismPlace/";
  static const String tourismPlaceSearchRatePath =
      "$baseUrl/api/TourismPlace/searchRateNamber/";
  static const String hotelsSearchRatePath =
      "$baseUrl/api/Hotel/searchRateNamber/";

  static const String getPlaceRateByUserPath =
      "$baseUrl/api/TourismPlace/getRate_TourismPlace/";
  static const String getHotelRateByUserPath =
      "$baseUrl/api/Hotel/getRate_Hotel/";

/* **************** Posts EndPoints **************** */
  static const String postPath = "$baseUrl/api/Post/";
/* **************** Comments EndPoints **************** */
  static const String getCommentPath =
      "$baseUrl/api/comment/getCommentByPostId/";
  static const String commentPath = "$baseUrl/api/comment/";
  static const String getLikePath = "$baseUrl/api/Post/getLike/";

/* **************** User EndPoints **************** */
  static const String userDetailsPath = "$baseUrl/rest-auth/user/";
  static const String registrationPath = "$baseUrl/rest-auth/registration/";
  static const String logInPath = "$baseUrl/rest-auth/login/";
  static const String logoutPath = "$baseUrl/rest-auth/logout/";
  static const String changePasswordPath =
      "$baseUrl/rest-auth/password/change/";
  static const String resetPasswordPath = "$baseUrl/password-reset/";
}
