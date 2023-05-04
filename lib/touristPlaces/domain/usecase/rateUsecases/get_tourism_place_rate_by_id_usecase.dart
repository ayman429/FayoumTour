import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../entities/tourism_place_rate.dart';
import '../../repository/base_tourism_place_repository.dart';

class GetTourismPlaceRateByIdUsecase
    extends BaseUseCase<TourismPlaceRate, String> {
  final BaseTourismPlaceRepository baseTourismPlaceRepository;

  GetTourismPlaceRateByIdUsecase(this.baseTourismPlaceRepository);
  @override
  Future<Either<Failure, TourismPlaceRate>> call(String parameters) async {
    return await baseTourismPlaceRepository.getTourismPlaceRateById(parameters);
  }
}
