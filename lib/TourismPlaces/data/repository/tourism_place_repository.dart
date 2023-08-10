import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/faliure.dart';
import '../../domain/entities/tourism_place.dart';
import '../../domain/entities/tourism_place_rate.dart';
import '../../domain/repository/base_tourism_place_repository.dart';
import '../datasource/tourism_place_remote_data_source.dart';

class TourismPlaceRerpository extends BaseTourismPlaceRepository {
  final BaseTourismPlaceRemoteDataSource baseTourismPlaceRemoteDataSource;
  TourismPlaceRerpository(
    this.baseTourismPlaceRemoteDataSource,
  );

  @override
  Future<Either<Failure, List<TourismPlace>>> getTourismPlace() async {
    try {
      final result = await baseTourismPlaceRemoteDataSource.getTourismPlaces();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> addTourismPlace(placeModel) async {
    try {
      final add =
          await baseTourismPlaceRemoteDataSource.addTourismPlaces(placeModel);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTourismPlace(placeModel) async {
    try {
      final add = await baseTourismPlaceRemoteDataSource
          .updateTourismPlaces(placeModel);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, String>> deleteTourismPlace(id) async {
    try {
      final result =
          await baseTourismPlaceRemoteDataSource.deleteTourismPlaces(id);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, TourismPlace>> getTourismPlaceById(id) async {
    try {
      final result =
          await baseTourismPlaceRemoteDataSource.getTourismPlacesById(id);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<TourismPlace>>> searchByField(search) async {
    try {
      final result =
          await baseTourismPlaceRemoteDataSource.searchByFields(search);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  // model1
  @override
  Future<Either<Failure, List<TourismPlace>>> model1(model1Input) async {
    try {
      final result =
          await baseTourismPlaceRemoteDataSource.model1Places(model1Input);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<TourismPlace>>> searchByRate() async {
    try {
      final result = await baseTourismPlaceRemoteDataSource.searchByRate();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<TourismPlace>>> orderingByField(search) async {
    try {
      final result =
          await baseTourismPlaceRemoteDataSource.orderingByFields(search);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<TourismPlaceRate>>> getTourismPlaceRate() async {
    try {
      final result =
          await baseTourismPlaceRemoteDataSource.getTourismPlaceRates();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, TourismPlaceRate>> getTourismPlaceRateById(id) async {
    try {
      final result =
          await baseTourismPlaceRemoteDataSource.getTourismPlaceRateById(id);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCreateTourismPlaceRate(
      tourismPlaceRateModel, tourismPlaceID) async {
    try {
      final add = await baseTourismPlaceRemoteDataSource
          .updateCreateTourismPlaceRates(tourismPlaceRateModel, tourismPlaceID);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, String>> getTourismPlaceRateByUser(
      placeId, userId) async {
    try {
      final add = await baseTourismPlaceRemoteDataSource
          .getTourismPlaceRateByUser(placeId, userId);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCreateTourismPlaceFavorite(
      tourismPlaceFavoriteModel) async {
    try {
      final add = await baseTourismPlaceRemoteDataSource
          .updateCreateTourismPlaceFavorites(tourismPlaceFavoriteModel);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<TourismPlace>>> getTourismPlaceFavorite() async {
    try {
      final add =
          await baseTourismPlaceRemoteDataSource.getTourismPlaceFavorites();
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }
}
