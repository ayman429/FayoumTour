import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/network/dio_factory.dart';
import '../../../core/network/error_message_model.dart';
import '../models/hotel_model.dart';
import '../models/hotel_rate_model.dart';

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
  Future<Unit> addHotelRates(HotelRateModel hotelRateModel, HotelID);
}

class HotelRemoteDataSource extends BaseHotelRemoteDataSource {
  @override
  Future<List<HotelModel>> getHotels() async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(
        ApiConstance.hotelPath,
      );
      return List<HotelModel>.from(
          (response.data as List).map((e) => HotelModel.fromJson(e)));
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
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
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
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
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
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
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
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
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
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
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
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
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
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
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
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
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<HotelRateModel> getHotelRateById(ID) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get("${ApiConstance.hotelRatePath}$ID/");
      return HotelRateModel.fromJson(response.data);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<Unit> addHotelRates(hotelRateModel, HotelID) async {
    Map<String, dynamic> hotelRateModelsToJson = hotelRateModel.toJson();
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.post(
          "${ApiConstance.hotelPath}${HotelID}/rate_Hotel/",
          data: hotelRateModelsToJson);
      return Future.value(unit);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
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