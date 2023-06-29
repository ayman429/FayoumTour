import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/local_data_shared_preferences/access_token_shared_preferences.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/network/dio_factory.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../domain/entities/user_details.dart';
import '../models/change_password_model.dart';
import '../models/login_model.dart';
import '../models/password_reset_confirm_model.dart';
import '../models/registration_model.dart';
import '../models/reset_password_model.dart';
import '../models/user_details_model.dart';

abstract class BaseAuthenticationRemoteDataSource {
  Future<UserDetailsModel> getUsersDetails();
  Future<String> updateUsersDetails(var userData, String type);
  Future<Unit> registration(RegistrationModel registrationModel);
  Future<Unit> logIn(LoginModel loginModel);
  Future<dynamic> logOut();
  Future<Unit> changePassword(ChangePasswordModel changePasswordModel);
  Future<Unit> resetPassword(ResetPasswordModel resetPasswordModel);
  Future<Unit> passwordResetConfirm(
      PasswordResetConfirmModel passwordResetConfirmModel);
}

class AuthenticationRemoteDataSource
    extends BaseAuthenticationRemoteDataSource {
  @override
  Future<UserDetailsModel> getUsersDetails() async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      // Get user info , Request and Response
      final response = await dio.get(ApiConstance.userDetailsPath);
      // return user info
      return UserDetailsModel.fromJson(response.data);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<Unit> registration(RegistrationModel registrationModel) async {
    Map<String, dynamic> registrationModelsToJson = registrationModel.toJson();
    try {
      // Send user info
      final response = await Dio()
          .post(ApiConstance.registrationPath, data: registrationModelsToJson);
      // Store Access Token
      AccessToken accessToken = AccessToken();
      accessToken.saveToken(response.data["key"]);

      // ------------------------------------------
      UserDetails userDetails = await getUsersDetails();
      await sharedPreferences!.setString("USERID", userDetails.id);
      String image = userDetails.image ?? "";

      sharedPreferences!.setString("USER", json.encode(userDetails.toJson()));
      sharedPreferences!.setString("username", userDetails.username);
      // print("=================>");
      // print(image);
      // print(userDetails.id);
      // print("${userDetails.id}USERIMAGE");
      sharedPreferences!.setString("${userDetails.id}USERIMAGE", image);
      //-------------------------------------------

      // return unit
      return Future.value(unit);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<Unit> logIn(LoginModel loginModel) async {
    Map<String, dynamic> loginModelToJson = loginModel.toJson();
    try {
      // Send user info
      final response =
          await Dio().post(ApiConstance.logInPath, data: loginModelToJson);
      // Store Access Token
      AccessToken accessToken = AccessToken();
      accessToken.saveToken(response.data["key"]);
      print(response.data);
      // ------------------------------------------
      UserDetails userDetails = await getUsersDetails();
      await sharedPreferences!.setString("USERID", userDetails.id);
      await sharedPreferences!
          .setBool("is_manager", userDetails.is_manager ?? false);
      await sharedPreferences!.setInt("managerId", userDetails.managerId ?? 0);
      String image = userDetails.image ?? "";

      sharedPreferences!.setString("USER", json.encode(userDetails.toJson()));
      sharedPreferences!.setString("username", userDetails.username);
      // print("=================>");
      // print(image);
      // print(userDetails.id);
      // print("${userDetails.id}USERIMAGE");
      sharedPreferences!.setString("${userDetails.id}USERIMAGE", image);
      //-------------------------------------------
      // return unit
      return Future.value(unit);
    } on DioError catch (e) {
      // return Error Message
      print("===============");
      print(e);
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<dynamic> logOut() async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      // LogOut
      final response = await dio.post(ApiConstance.logoutPath);
      print("res = ${response.data}");
      // return unit
      // return Future.value(unit);
      return response.data;
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<Unit> changePassword(ChangePasswordModel changePasswordModel) async {
    final Map<String, dynamic> changePasswordToJson =
        changePasswordModel.toJson();
    try {
      print("password: $changePasswordToJson");
      Dio dio = (await DioFactory.create()).dio;
      // Change Password , Request and Response
      final response = await dio.post(ApiConstance.changePasswordPath,
          data: changePasswordToJson);
      print(response.data);
      // return unit
      return Future.value(unit);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<Unit> resetPassword(ResetPasswordModel resetPasswordModel) async {
    final resetPasswordToJson = resetPasswordModel.toJson();
    // print("resetPasswordToJson = $resetPasswordToJson");
    try {
      // Reset Password , Request and Response
      final response = await Dio()
          .post(ApiConstance.resetPasswordPath, data: resetPasswordToJson);
      print("response = ${response.data}");
      // return unit
      return Future.value(unit);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<Unit> passwordResetConfirm(
      PasswordResetConfirmModel passwordResetConfirmModel) {
    final passwordResetConfirmToJson = passwordResetConfirmModel.toJson();
    try {
      // password Reset Confirm , Request and Response
      final response = Dio().post(passwordResetConfirmModel.link,
          data: passwordResetConfirmToJson);
      // return unit
      return Future.value(unit);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<String> updateUsersDetails(userData, type) async {
    try {
      // print("==============> $userName");
      Dio dio = (await DioFactory.create()).dio;
      // Get user info , Request and Response
      if (type == "username") {
        final response = await dio
            .patch(ApiConstance.userDetailsPath, data: {"username": userData});
        print(response.data["username"].toString());
        // return user info
        return response.data["username"].toString();
      } else if (type == "image") {
        final response = await dio.patch(
          ApiConstance.userDetailsPath,
          data: FormData.fromMap({
            "image": await MultipartFile.fromFile(userData),
          }),
        );
        print(response.data["image"].toString());
        // return user info
        return response.data["image"].toString();
      } else {
        return "Have Some error";
      }
      // return UserDetailsModel.fromJson(response.data);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }
}
