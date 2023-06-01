import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';

import '../../repository/base_tourism_place_repository.dart';

class GetTourismPlaceRateByUserUsecase {
  // extends BaseUseCase<TourismPlaceRate, String>
  final BaseTourismPlaceRepository baseTourismPlaceRepository;

  GetTourismPlaceRateByUserUsecase(this.baseTourismPlaceRepository);
  @override
  Future<Either<Failure, String>> call(String placeId, String userId) async {
    return await baseTourismPlaceRepository.getTourismPlaceRateByUser(
        placeId, userId);
  }
}
