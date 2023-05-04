import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../data/models/hotel_model.dart';
import '../../data/models/hotel_rate_model.dart';
import '../entities/hotel.dart';
import '../entities/hotel_rate.dart';

abstract class BaseHotelRepository {
  Future<Either<Failure, List<Hotel>>> getHotel();
  Future<Either<Failure, Hotel>> getHotelById(String ID);
  Future<Either<Failure, List<Hotel>>> searchByField(String search);
  Future<Either<Failure, List<Hotel>>> searchByRate(int search);
  Future<Either<Failure, List<Hotel>>> orderingByField(search);
  Future<Either<Failure, String>> deleteHotel(String ID);
  Future<Either<Failure, Unit>> addHotel(HotelModel hotelModel);
  Future<Either<Failure, Unit>> updateHotel(HotelModel hotelModel);
  Future<Either<Failure, List<HotelRate>>> getHotelRate();
  Future<Either<Failure, HotelRate>> getHotelRateById(String ID);
  Future<Either<Failure, Unit>> updateCreateHotelRate(
      HotelRateModel hotelRateModel, String HotelID);
}
