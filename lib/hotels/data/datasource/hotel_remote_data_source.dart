// ignore_for_file: non_constant_identifier_names, avoid_renaming_method_parameters, unused_local_variable

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/network/dio_factory.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../models/hotel_favorite_model.dart';
import '../models/hotel_model.dart';
import '../models/hotel_rate_model.dart';
import '../models/hotel_reservation_model.dart';

abstract class BaseHotelRemoteDataSource {
  Future<List<HotelModel>> getHotels();
  Future<List<HotelModel>> searchByFields(search);
  Future<List<HotelModel>> searchByRate();
  Future<List<HotelModel>> orderingByFields(search);
  Future<HotelModel> getHotelsById(ID);
  Future<String> deleteHotels(ID);
  Future<Unit> addHotels(HotelModel HotelModel);
  Future<Unit> updateHotels(HotelModel HotelModel);

  Future<List<HotelRateModel>> getHotelRates();
  Future<HotelRateModel> getHotelRateById(ID);
  Future<Unit> updateCreateHotelRates(HotelRateModel hotelRateModel, HotelID);
  Future<String> getHotelRateByUser(int hotelId, int userId);

  Future<Unit> updateCreateHotelFavorites(
      HotelFavoriteModel hotelFavoriteModel);
  Future<List<HotelModel>> getHotelFavorites();

  // HotelReservation
  Future<List<HotelReservationModel>> getHotelsReservation(int hotelId);
  Future<List<HotelReservationModel>> getHotelsReservationByUser(int userId);
  Future<String> deleteHotelsReservation(id);
  Future<Unit> addHotelsReservation(
      HotelReservationModel hotelReservationModel);
  Future<Unit> updateHotelsReservation(
      HotelReservationModel hotelReservationModel);
  Future<Unit> updateHotelsReservationByUser(
      HotelReservationModel hotelReservationModel, String reservationId);
}

class HotelRemoteDataSource extends BaseHotelRemoteDataSource {
  @override
  Future<List<HotelModel>> getHotels() async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(
        ApiConstance.hotelPath,
      );
      return List<HotelModel>.from((response.data as List)
          .map((e) => HotelModel.fromJson(e)));
    } on DioException catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<Unit> addHotels(hotelModel) async {
    Map<String, dynamic> hotelModelsToJson = hotelModel.toJson();
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response =
          await dio.post(ApiConstance.hotelPath, data: hotelModelsToJson);
      return Future.value(unit);
    } on DioException catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<Unit> updateHotels(hotelModel) async {
    Map<String, dynamic> hotelModelsToJson = hotelModel.toJson();
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response =
          await dio.put(ApiConstance.hotelPath, data: hotelModelsToJson);
      return Future.value(unit);
    } on DioException catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<String> deleteHotels(ID) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.delete(
        "${ApiConstance.hotelPath}$ID/",
      );
      return "Deleted";
    } on DioException catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<HotelModel> getHotelsById(ID) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(
        "${ApiConstance.hotelPath}$ID/",
      );

      return HotelModel.fromJson(response.data);
    } on DioException catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<List<HotelModel>> searchByFields(search) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio
          .get(ApiConstance.hotelPath, queryParameters: {"search": search});
      return List<HotelModel>.from(
          (response.data as List).map((e) => HotelModel.fromJson(e)));
    } on DioException catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.error.toString()),
      );
    }
  }

  @override
  Future<List<HotelModel>> searchByRate() async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(
        ApiConstance.hotelsSearchRatePath,
        //  queryParameters: {"RateNamber": search}
      );

      return List<HotelModel>.from(
          (response.data as List).map((e) => HotelModel.fromJson(e)));
    } on DioException catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.error.toString()),
      );
    }
  }

  @override
  Future<List<HotelModel>> orderingByFields(search) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio
          .get(ApiConstance.hotelPath, queryParameters: {"ordering": search});

      return List<HotelModel>.from(
          (response.data as List).map((e) => HotelModel.fromJson(e)));
    } on DioException catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<List<HotelRateModel>> getHotelRates() async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(ApiConstance.hotelRatePath);

      return List<HotelRateModel>.from(
          (response.data as List).map((e) => HotelRateModel.fromJson(e)));
    } on DioException catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<HotelRateModel> getHotelRateById(ID) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get("${ApiConstance.hotelRatePath}$ID/");
      return HotelRateModel.fromJson(response.data);
    } on DioException catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<Unit> updateCreateHotelRates(hotelRateModel, HotelID) async {
    Map<String, dynamic> hotelRateModelsToJson = hotelRateModel.toJson();
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.post(
          "${ApiConstance.hotelPath}$HotelID/rate_Hotel/",
          data: hotelRateModelsToJson);
      return Future.value(unit);
    } on DioException catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<String> getHotelRateByUser(hotelId, userId) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(ApiConstance.getHotelRateByUserPath,
          data: {"hotelId": hotelId, "userId": userId});
      // print(response.data);
      return response.data["star"] ?? "0";
    } on DioException catch (e) {
      // return Error Message
      //print("=============>");
      //print(e.message);
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<Unit> updateCreateHotelFavorites(hotelFavoriteModel) async {
    Map<String, dynamic> hotelFavoriteModelsToJson =
        hotelFavoriteModel.toJson();
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.post(
          "${ApiConstance.hotelPath}${hotelFavoriteModelsToJson["hotelId"]}/fav/",
          data: {
            "fav": hotelFavoriteModelsToJson["fav"],
            "user": hotelFavoriteModelsToJson["username"]
          });
      return Future.value(unit);
    } on DioException catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<List<HotelModel>> getHotelFavorites() async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(ApiConstance.hotelFavoritePath, data: {
        "userId": int.parse(sharedPreferences!.getString("USERID") ?? "0")
      });
      return List<HotelModel>.from(
          (response.data as List).map((e) => HotelModel.fromJson(e)));
    } on DioException catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  // HotelReservation
  @override
  Future<List<HotelReservationModel>> getHotelsReservation(hotelId) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(
        ApiConstance.getHotelReservationPath,
        data: {"hotelId": hotelId},
      );
      return List<HotelReservationModel>.from((response.data as List)
          .map((e) => HotelReservationModel.fromJson(e)));
    } on DioException catch (e) {
      // return Error Message
      //print("====================");
      //print(e.response);
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<List<HotelReservationModel>> getHotelsReservationByUser(userId) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(ApiConstance.getHotelReservationByUserPath,
          data: {"user": userId});
      // print("====================");
      // print(response.data);
      return List<HotelReservationModel>.from((response.data as List)
          .map((e) => HotelReservationModel.fromJson(e)));
    } on DioException catch (e) {
      // return Error Message
      //print("====================");
      //print(e.response);
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<Unit> addHotelsReservation(hotelReservationModel) async {
    Map<String, dynamic> hotelReservationModelsToJson =
        hotelReservationModel.toJson();
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.post(ApiConstance.hotelReservationPath,
          data: hotelReservationModelsToJson);
      return Future.value(unit);
    } on DioException catch (e) {
      // return Error Message
      //print("=================");
      //print(e.response);
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<Unit> updateHotelsReservation(hotelReservationModel) async {
    //print("------------------------>");
    Map<String, dynamic> hotelReservationModelsToJson =
        hotelReservationModel.toJson();
    //print(hotelReservationModelsToJson["id"]);

    try {
      Dio dio = (await DioFactory.create()).dio;
      // ignore: prefer_interpolation_to_compose_strings
      final response = await dio.patch("${"${ApiConstance.hotelReservationPath}/" + hotelReservationModelsToJson["id"]}/",
          data: hotelReservationModelsToJson);
      return Future.value(unit);
    } on DioException catch (e) {
      // return Error Message
      //print("..................");
      //print(e.response);
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<Unit> updateHotelsReservationByUser(
      hotelReservationModel, reservationId) async {
    Map<String, dynamic> hotelReservationModelsToJson =
        hotelReservationModel.toJson();
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.patch(
          "${ApiConstance.hotelReservationPath}/$reservationId/updateReservation/",
          data: {"status": hotelReservationModelsToJson["status"]});
      return Future.value(unit);
    } on DioException catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }

  @override
  Future<String> deleteHotelsReservation(id) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.delete(
        "${ApiConstance.hotelReservationPath}$id/",
      );
      return "Deleted";
    } on DioException catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.message),
      );
    }
  }
}








 // List HotelModelToJson =
    //     HotelModel.map<Map<String, dynamic>>((e) => e.toJson()).toList();
    // Map<String, dynamic> HotelModelToJson = hotelModel.toJson();
    // print("HotelModelToJson = $HotelModelToJson");
    // final response =
    //     await Dio().post(ApiConstance.hotelPath, data: HotelModelToJson);
    // return Future.value(unit);

    // if (response.statusCode == 200) {
    //   // print(response.data.toString());
    //   return HotelModel.toJson();
    // }