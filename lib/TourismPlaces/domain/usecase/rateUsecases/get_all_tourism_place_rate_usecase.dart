import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../entities/tourism_place_rate.dart';
import '../../repository/base_tourism_place_repository.dart';

class GetTourismPlaceRateUsecase
    extends BaseUseCase<List<TourismPlaceRate>, NoParameters> {
  final BaseTourismPlaceRepository baseTourismPlaceRepository;

  GetTourismPlaceRateUsecase(this.baseTourismPlaceRepository);
  @override
  Future<Either<Failure, List<TourismPlaceRate>>> call(
      NoParameters parameters) async {
    return await baseTourismPlaceRepository.getTourismPlaceRate();
  }
}
