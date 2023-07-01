import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../data/models/tourism_place_model.dart';
import '../../data/models/tourism_place_rate_model.dart';
import '../entities/tourism_place.dart';
import '../entities/tourism_place_rate.dart';

abstract class BaseTourismPlaceRepository {
  Future<Either<Failure, List<TourismPlace>>> getTourismPlace();
  Future<Either<Failure, TourismPlace>> getTourismPlaceById(String id);
  Future<Either<Failure, List<TourismPlace>>> searchByField(String search);
  Future<Either<Failure, List<TourismPlace>>> model1(String model1Input);
  Future<Either<Failure, List<TourismPlace>>> searchByRate();
  Future<Either<Failure, List<TourismPlace>>> orderingByField(search);
  Future<Either<Failure, String>> deleteTourismPlace(String id);
  Future<Either<Failure, Unit>> addTourismPlace(TourismPlaceModel placeModel);
  Future<Either<Failure, Unit>> updateTourismPlace(
      TourismPlaceModel placeModel);
  Future<Either<Failure, List<TourismPlaceRate>>> getTourismPlaceRate();
  Future<Either<Failure, TourismPlaceRate>> getTourismPlaceRateById(String id);
  Future<Either<Failure, Unit>> updateCreateTourismPlaceRate(
      TourismPlaceRateModel tourismPlaceRateModel, String tourismPlaceID);

  Future<Either<Failure, String>> getTourismPlaceRateByUser(
      int placeId, int userId);
}
