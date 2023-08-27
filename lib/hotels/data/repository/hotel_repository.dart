// ignore_for_file: non_constant_identifier_names, avoid_renaming_method_parameters

import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/faliure.dart';
import '../../domain/entities/hotel.dart';
import '../../domain/entities/hotel_rate.dart';
import '../../domain/entities/hotel_reservation.dart';
import '../../domain/repository/base_hotel_repository.dart';
import '../datasource/hotel_remote_data_source.dart';

class HotelRerpository extends BaseHotelRepository {
  final BaseHotelRemoteDataSource baseHotelRemoteDataSource;
  HotelRerpository(
    this.baseHotelRemoteDataSource,
  );

  @override
  Future<Either<Failure, List<Hotel>>> getHotel() async {
    try {
      final result = await baseHotelRemoteDataSource.getHotels();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> addHotel(hotelModel) async {
    try {
      final add = await baseHotelRemoteDataSource.addHotels(hotelModel);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateHotel(hotelModel) async {
    try {
      final add = await baseHotelRemoteDataSource.updateHotels(hotelModel);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, String>> deleteHotel(ID) async {
    try {
      final result = await baseHotelRemoteDataSource.deleteHotels(ID);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Hotel>> getHotelById(ID) async {
    try {
      final result = await baseHotelRemoteDataSource.getHotelsById(ID);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<Hotel>>> searchByField(search) async {
    try {
      final result = await baseHotelRemoteDataSource.searchByFields(search);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<Hotel>>> searchByRate() async {
    try {
      final result = await baseHotelRemoteDataSource.searchByRate();

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<Hotel>>> orderingByField(search) async {
    try {
      final result = await baseHotelRemoteDataSource.orderingByFields(search);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<HotelRate>>> getHotelRate() async {
    try {
      final result = await baseHotelRemoteDataSource.getHotelRates();

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, HotelRate>> getHotelRateById(ID) async {
    try {
      final result = await baseHotelRemoteDataSource.getHotelRateById(ID);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCreateHotelRate(
      hotelRateModel, HotelID) async {
    try {
      final add = await baseHotelRemoteDataSource.updateCreateHotelRates(
          hotelRateModel, HotelID);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, String>> getHotelRateByUser(hotelId, userId) async {
    try {
      final add =
          await baseHotelRemoteDataSource.getHotelRateByUser(hotelId, userId);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCreateHotelFavorite(
      hotelFavoriteModel) async {
    try {
      final add = await baseHotelRemoteDataSource
          .updateCreateHotelFavorites(hotelFavoriteModel);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<Hotel>>> getHotelFavorite() async {
    try {
      final add = await baseHotelRemoteDataSource.getHotelFavorites();

      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  // HotelReservation
  @override
  Future<Either<Failure, List<HotelReservation>>> getHotelReservation(
      int hotelId) async {
    try {
      final result =
          await baseHotelRemoteDataSource.getHotelsReservation(hotelId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<HotelReservation>>> getHotelReservationByUser(
      int userId) async {
    try {
      final result =
          await baseHotelRemoteDataSource.getHotelsReservationByUser(userId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> addHotelReservation(
      hotelModelReservation) async {
    try {
      final add = await baseHotelRemoteDataSource
          .addHotelsReservation(hotelModelReservation);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateHotelReservation(
      hotelReservationModel) async {
    try {
      final add = await baseHotelRemoteDataSource
          .updateHotelsReservation(hotelReservationModel);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  //updateHotelsReservationByUser
  @override
  Future<Either<Failure, Unit>> updateHotelReservationByUser(
      hotelReservationModel, reservationId) async {
    try {
      final add = await baseHotelRemoteDataSource.updateHotelsReservationByUser(
          hotelReservationModel, reservationId);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, String>> deleteHotelReservation(id) async {
    try {
      final result =
          await baseHotelRemoteDataSource.deleteHotelsReservation(id);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }
}
