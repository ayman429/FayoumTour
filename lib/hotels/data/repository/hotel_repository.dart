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
    final result = await baseHotelRemoteDataSource.getHotels();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> addHotel(hotelModel) async {
    final add = await baseHotelRemoteDataSource.addHotels(hotelModel);
    try {
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateHotel(hotelModel) async {
    final add = await baseHotelRemoteDataSource.updateHotels(hotelModel);
    try {
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, String>> deleteHotel(ID) async {
    final result = await baseHotelRemoteDataSource.deleteHotels(ID);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Hotel>> getHotelById(ID) async {
    final result = await baseHotelRemoteDataSource.getHotelsById(ID);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<Hotel>>> searchByField(search) async {
    final result = await baseHotelRemoteDataSource.searchByFields(search);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<Hotel>>> searchByRate() async {
    final result = await baseHotelRemoteDataSource.searchByRate();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<Hotel>>> orderingByField(search) async {
    final result = await baseHotelRemoteDataSource.orderingByFields(search);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<HotelRate>>> getHotelRate() async {
    final result = await baseHotelRemoteDataSource.getHotelRates();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, HotelRate>> getHotelRateById(ID) async {
    final result = await baseHotelRemoteDataSource.getHotelRateById(ID);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCreateHotelRate(
      hotelRateModel, HotelID) async {
    final add = await baseHotelRemoteDataSource.updateCreateHotelRates(
        hotelRateModel, HotelID);
    try {
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, String>> getHotelRateByUser(hotelId, userId) async {
    final add =
        await baseHotelRemoteDataSource.getHotelRateByUser(hotelId, userId);
    try {
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  // HotelReservation
  @override
  Future<Either<Failure, List<HotelReservation>>> getHotelReservation(
      int hotelId) async {
    final result =
        await baseHotelRemoteDataSource.getHotelsReservation(hotelId);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, List<HotelReservation>>> getHotelReservationByUser(
      int userId) async {
    final result =
        await baseHotelRemoteDataSource.getHotelsReservationByUser(userId);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> addHotelReservation(
      hotelModelReservation) async {
    final add = await baseHotelRemoteDataSource
        .addHotelsReservation(hotelModelReservation);
    try {
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateHotelReservation(
      hotelReservationModel) async {
    final add = await baseHotelRemoteDataSource
        .updateHotelsReservation(hotelReservationModel);
    try {
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, String>> deleteHotelReservation(id) async {
    final result = await baseHotelRemoteDataSource.deleteHotelsReservation(id);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }
}
