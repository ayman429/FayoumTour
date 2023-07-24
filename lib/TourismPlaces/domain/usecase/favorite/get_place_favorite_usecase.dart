import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../data/models/tourism_place_favorite_model.dart';
import '../../../data/models/tourism_place_model.dart';
import '../../entities/tourism_place.dart';
import '../../entities/tourism_place_favorite.dart';
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
