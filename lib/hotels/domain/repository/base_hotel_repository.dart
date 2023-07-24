import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../data/models/hotel_favorite_model.dart';
import '../../data/models/hotel_model.dart';
import '../../data/models/hotel_rate_model.dart';
import '../../data/models/hotel_reservation_model.dart';
import '../entities/hotel.dart';
import '../entities/hotel_rate.dart';
import '../entities/hotel_reservation.dart';

abstract class BaseHotelRepository {
  Future<Either<Failure, List<Hotel>>> getHotel();
  Future<Either<Failure, Hotel>> getHotelById(String ID);
  Future<Either<Failure, List<Hotel>>> searchByField(String search);
  Future<Either<Failure, List<Hotel>>> searchByRate();
  Future<Either<Failure, List<Hotel>>> orderingByField(search);
  Future<Either<Failure, String>> deleteHotel(String ID);
  Future<Either<Failure, Unit>> addHotel(HotelModel hotelModel);
  Future<Either<Failure, Unit>> updateHotel(HotelModel hotelModel);
  Future<Either<Failure, List<HotelRate>>> getHotelRate();
  Future<Either<Failure, HotelRate>> getHotelRateById(String ID);
  Future<Either<Failure, Unit>> updateCreateHotelRate(
      HotelRateModel hotelRateModel, String HotelID);

  Future<Either<Failure, String>> getHotelRateByUser(int hotelId, int userId);

  Future<Either<Failure, Unit>> updateCreateHotelFavorite(
      HotelFavoriteModel hotelFavoriteModel);

  Future<Either<Failure, List<Hotel>>> getHotelFavorite();

  // HotelReservation
  Future<Either<Failure, List<HotelReservation>>> getHotelReservation(
      int hotelId);
  Future<Either<Failure, List<HotelReservation>>> getHotelReservationByUser(
      int userId);
  Future<Either<Failure, Unit>> addHotelReservation(
      HotelReservationModel hotelReservationModel);
  Future<Either<Failure, Unit>> updateHotelReservation(
      HotelReservationModel hotelReservationModel);
  Future<Either<Failure, String>> deleteHotelReservation(String id);
}
