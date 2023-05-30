import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/network/dio_factory.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../models/post_model.dart';

abstract class BasePostRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPostsById(iD);
  Future<String> deletePosts(iD);
  Future<Unit> addPosts(String body, List<String> images);
  Future<Unit> updatePosts(PostModel postModel);

  // Future<List<PostModel>> searchByFields(search);
  // Future<List<HotelModel>> orderingByFields(search);

}

class PostRemoteDataSource extends BasePostRemoteDataSource {
  @override
  Future<List<PostModel>> getPosts() async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(
        ApiConstance.postPath,
      );
      return List<PostModel>.from(
          (response.data as List).map((e) => PostModel.fromJson(e)));
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<Unit> addPosts(String body, List<String> images) async {
    // Map<String, dynamic> postModelsToJson = postModel.toJson();

    try {
      int user = int.parse(sharedPreferences!.getString("USERID") ?? "0");
      print("============================>");
      print(user);
      FormData formData = FormData();

      // Add the images to the form data
      for (int i = 0; i < images.length; i++) {
        String imagePath = images[i];
        formData.files.add(MapEntry(
          'uploaded_images',
          await MultipartFile.fromFile(
            imagePath,
          ),
        ));
      }
      // Add user and body as fields to the form data
      formData.fields.add(MapEntry('user', user.toString()));
      formData.fields.add(MapEntry('body', body));
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.post(ApiConstance.postPath, data: formData);

      return Future.value(unit);
    } on DioError catch (e) {
      print("================>");
      print(e);
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<Unit> updatePosts(postModel) async {
    Map<String, dynamic> postModelsToJson = postModel.toJson();
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response =
          await dio.put(ApiConstance.postPath, data: postModelsToJson);
      return Future.value(unit);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<String> deletePosts(iD) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.delete(
        "${ApiConstance.postPath}$iD/",
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
  Future<PostModel> getPostsById(iD) async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      final response = await dio.get(
        "${ApiConstance.postPath}$iD/",
      );

      return PostModel.fromJson(response.data);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  // @override
  // Future<List<HotelModel>> searchByFields(search) async {
  //   try {
  //     Dio dio = (await DioFactory.create()).dio;
  //     final response = await dio
  //         .get(ApiConstance.hotelPath, queryParameters: {"search": search});
  //     return List<HotelModel>.from(
  //         (response.data as List).map((e) => HotelModel.fromJson(e)));
  //   } on DioError catch (e) {
  //     // return Error Message
  //     throw ServerException(
  //       errorMassageModel: ErrorMassageModel.fromJson(e.response),
  //     );
  //   }
  // }

  // @override
  // Future<List<HotelModel>> orderingByFields(search) async {
  //   try {
  //     Dio dio = (await DioFactory.create()).dio;
  //     final response = await dio
  //         .get(ApiConstance.hotelPath, queryParameters: {"ordering": search});

  //     return List<HotelModel>.from(
  //         (response.data as List).map((e) => HotelModel.fromJson(e)));
  //   } on DioError catch (e) {
  //     // return Error Message
  //     throw ServerException(
  //       errorMassageModel: ErrorMassageModel.fromJson(e.response),
  //     );
  //   }
  // }

}
