import 'package:dartz/dartz.dart';
import 'package:fayoumtour/touristPlaces/domain/repository/base_tourism_place_repository.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/faliure.dart';
import '../../domain/entities/tourism_place.dart';
import '../../domain/entities/tourism_place_rate.dart';
import '../datasource/tourism_place_remote_data_source.dart';

class TourismPlaceRerpository extends BaseTourismPlaceRepository {
  final BaseTourismPlaceRemoteDataSource baseTourismPlaceRemoteDataSource;
  TourismPlaceRerpository(
    this.baseTourismPlaceRemoteDataSource,
  );

  @override
  Future<Either<Failure, List<TourismPlace>>> getTourismPlace() async {
    final result = await baseTourismPlaceRemoteDataSource.getTourismPlaces();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> addTourismPlace(placeModel) async {
    final add =
        await baseTourismPlaceRemoteDataSource.addTourismPlaces(placeModel);
    try {
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTourismPlace(placeModel) async {
    final add =
        await baseTourismPlaceRemoteDataSource.updateTourismPlaces(placeModel);
    try {
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, String>> deleteTourismPlace(id) async {
    final result =
        await baseTourismPlaceRemoteDataSource.deleteTourismPlaces(id);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, TourismPlace>> getTourismPlaceById(id) async {
    final result =
        await baseTourismPlaceRemoteDataSource.getTourismPlacesById(id);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<TourismPlace>>> searchByField(search) async {
    final result =
        await baseTourismPlaceRemoteDataSource.searchByFields(search);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<TourismPlace>>> searchByRate(search) async {
    final result = await baseTourismPlaceRemoteDataSource.searchByRate(search);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<TourismPlace>>> orderingByField(search) async {
    final result =
        await baseTourismPlaceRemoteDataSource.orderingByFields(search);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<TourismPlaceRate>>> getTourismPlaceRate() async {
    final result =
        await baseTourismPlaceRemoteDataSource.getTourismPlaceRates();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, TourismPlaceRate>> getTourismPlaceRateById(id) async {
    final result =
        await baseTourismPlaceRemoteDataSource.getTourismPlaceRateById(id);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCreateTourismPlaceRate(
      tourismPlaceRateModel, tourismPlaceID) async {
    final add = await baseTourismPlaceRemoteDataSource
        .updateCreateTourismPlaceRates(tourismPlaceRateModel, tourismPlaceID);
    try {
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }
}
