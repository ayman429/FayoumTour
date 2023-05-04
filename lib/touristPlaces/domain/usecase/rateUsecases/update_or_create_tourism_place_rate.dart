import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../data/models/tourism_place_rate_model.dart';
import '../../repository/base_tourism_place_repository.dart';

class UpdateCreateTourismPlaceRateUsecase {
  final BaseTourismPlaceRepository baseTourismPlaceRepository;

  UpdateCreateTourismPlaceRateUsecase(this.baseTourismPlaceRepository);
  Future<Either<Failure, Unit>> call(
      TourismPlaceRateModel tourismPlaceRateModel,
      String tourismPlaceID) async {
    return await baseTourismPlaceRepository.updateCreateTourismPlaceRate(
        tourismPlaceRateModel, tourismPlaceID);
  }
}
