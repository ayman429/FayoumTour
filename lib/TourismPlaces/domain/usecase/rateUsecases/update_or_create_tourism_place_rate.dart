import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../data/models/tourism_place_rate_model.dart';
import '../../entities/tourism_place_rate.dart';
import '../../repository/base_tourism_place_repository.dart';

class UpdateCreateTourismPlaceRateUsecase {
  final BaseTourismPlaceRepository baseTourismPlaceRepository;

  UpdateCreateTourismPlaceRateUsecase(this.baseTourismPlaceRepository);
  Future<Either<Failure, Unit>> call(
      TourismPlaceRate parameters, String tourismPlaceID) async {
    TourismPlaceRateModel tourismPlaceRateModel =
        TourismPlaceRateModel.castFromEntity(parameters);
    return await baseTourismPlaceRepository.updateCreateTourismPlaceRate(
        tourismPlaceRateModel, tourismPlaceID);
  }
}
