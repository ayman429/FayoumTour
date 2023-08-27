import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../../data/models/hotel_favorite_model.dart';
import '../../entities/hotel_favorite.dart';
import '../../repository/base_hotel_repository.dart';

class UpdateCreateHotelFavoriteUsecase
    extends BaseUseCase<Unit, HotelFavorite> {
  final BaseHotelRepository baseHotelRepository;

  UpdateCreateHotelFavoriteUsecase(this.baseHotelRepository);
  @override
  Future<Either<Failure, Unit>> call(HotelFavorite parameters) async {
    HotelFavoriteModel tourismPlaceFavoriteModel =
        HotelFavoriteModel.castFromEntity(parameters);
    return await baseHotelRepository
        .updateCreateHotelFavorite(tourismPlaceFavoriteModel);
  }
}
