import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/network/dio_factory.dart';
import '../../../core/network/error_message_model.dart';
import '../models/tourism_place_model.dart';
import '../models/tourism_place_rate_model.dart';

abstract class BaseTourismPlaceRemoteDataSource {
  Future<List<TourismPlaceModel>> getTourismPlaces();
  Future<List<TourismPlaceModel>> searchByFields(search);
  Future<List<TourismPlaceModel>> searchByRate(search);
  Future<List<TourismPlaceModel>> orderingByFields(search);
  Future<TourismPlaceModel> getTourismPlacesById(id);
  Future<String> deleteTourismPlaces(id);
  Future<Unit> addTourismPlaces(TourismPlaceModel tourismPlaceModel);
  Future<Unit> updateTourismPlaces(TourismPlaceModel tourismPlaceModel);

  Future<List<TourismPlaceRateModel>> getTourismPlaceRates();
  Future<TourismPlaceRateModel> getTourismPlaceRateById(id);
  Future<Unit> updateCreateTourismPlaceRates(
      TourismPlaceRateModel tourismPlaceRateModel, tourismPlaceID);
}

class TourismPlaceRemoteDataSource extends BaseTourismPlaceRemoteDataSource {
  @override
  Future<List<TourismPlaceModel>> getTourismPlaces() async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(
        ApiConstance.tourismPlacePath,
      );
      return List<TourismPlaceModel>.from(
          (response.data as List).map((e) => TourismPlaceModel.fromJson(e)));
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<Unit> addTourismPlaces(tourismPlaceModel) async {
    Map<String, dynamic> tourismPlaceModelsToJson = tourismPlaceModel.toJson();
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.post(ApiConstance.tourismPlacePath,
          data: tourismPlaceModelsToJson);
      return Future.value(unit);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<Unit> updateTourismPlaces(tourismPlaceModel) async {
    Map<String, dynamic> tourismPlaceModelsToJson = tourismPlaceModel.toJson();
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.put(ApiConstance.tourismPlacePath,
          data: tourismPlaceModelsToJson);
      return Future.value(unit);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<String> deleteTourismPlaces(id) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.delete(
        "${ApiConstance.tourismPlacePath}$id/",
      );
      return "Deleted";
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<TourismPlaceModel> getTourismPlacesById(id) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(
        "${ApiConstance.tourismPlacePath}$id/",
      );

      return TourismPlaceModel.fromJson(response.data);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<List<TourismPlaceModel>> searchByFields(search) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(ApiConstance.tourismPlacePath,
          queryParameters: {"search": search});
      return List<TourismPlaceModel>.from(
          (response.data as List).map((e) => TourismPlaceModel.fromJson(e)));
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<List<TourismPlaceModel>> searchByRate(search) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(ApiConstance.tourismPlacePath,
          queryParameters: {"RateNamber": search});

      return List<TourismPlaceModel>.from(
          (response.data as List).map((e) => TourismPlaceModel.fromJson(e)));
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<List<TourismPlaceModel>> orderingByFields(search) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(ApiConstance.tourismPlacePath,
          queryParameters: {"ordering": search});

      return List<TourismPlaceModel>.from(
          (response.data as List).map((e) => TourismPlaceModel.fromJson(e)));
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<List<TourismPlaceRateModel>> getTourismPlaceRates() async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(ApiConstance.tourismPlaceRatePath);

      return List<TourismPlaceRateModel>.from((response.data as List)
          .map((e) => TourismPlaceRateModel.fromJson(e)));
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<TourismPlaceRateModel> getTourismPlaceRateById(id) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get("${ApiConstance.hotelRatePath}$id/");
      return TourismPlaceRateModel.fromJson(response.data);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<Unit> updateCreateTourismPlaceRates(
      tourismPlaceRateModel, tourismPlaceID) async {
    Map<String, dynamic> tourismPlaceRateModelsToJson =
        tourismPlaceRateModel.toJson();
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.post(
          "${ApiConstance.tourismPlacePath}$tourismPlaceID/rate_TourismPlace/",
          data: tourismPlaceRateModelsToJson);
      return Future.value(unit);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }
}
