import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../entities/tourism_place.dart';
import '../../repository/base_tourism_place_repository.dart';

class GetTourismPlaceFavoriteUsecase
    extends BaseUseCase<List<TourismPlace>, NoParameters> {
  final BaseTourismPlaceRepository baseTourismPlaceRepository;

  GetTourismPlaceFavoriteUsecase(this.baseTourismPlaceRepository);
  @override
  Future<Either<Failure, List<TourismPlace>>> call(
      NoParameters parameters) async {
    return await baseTourismPlaceRepository.getTourismPlaceFavorite();
  }
}
