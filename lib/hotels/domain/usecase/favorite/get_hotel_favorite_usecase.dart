import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../data/models/hotel_favorite_model.dart';
import '../../entities/hotel_favorite.dart';
import '../../repository/base_hotel_repository.dart';

class GetHotelFavoriteUsecase extends BaseUseCase<String, HotelFavorite> {
  final BaseHotelRepository baseHotelRepository;

  GetHotelFavoriteUsecase(this.baseHotelRepository);
  @override
  Future<Either<Failure, String>> call(HotelFavorite parameters) async {
    HotelFavoriteModel hotelFavoriteModel =
        HotelFavoriteModel.castFromEntity(parameters);
    return await baseHotelRepository.getHotelFavorite(hotelFavoriteModel);
  }
}
