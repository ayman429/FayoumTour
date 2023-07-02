import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../data/models/tourism_place_favorite_model.dart';
import '../../entities/tourism_place_favorite.dart';
import '../../repository/base_tourism_place_repository.dart';

class GetTourismPlaceFavoriteUsecase
    extends BaseUseCase<String, TourismPlaceFavorite> {
  final BaseTourismPlaceRepository baseTourismPlaceRepository;

  GetTourismPlaceFavoriteUsecase(this.baseTourismPlaceRepository);
  @override
  Future<Either<Failure, String>> call(TourismPlaceFavorite parameters) async {
    TourismPlaceFavoriteModel tourismPlaceFavoriteModel =
        TourismPlaceFavoriteModel.castFromEntity(parameters);
    return await baseTourismPlaceRepository
        .getTourismPlaceFavorite(tourismPlaceFavoriteModel);
  }
}
