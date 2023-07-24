import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../entities/hotel.dart';
import '../../repository/base_hotel_repository.dart';

class GetHotelFavoriteUsecase extends BaseUseCase<List<Hotel>, NoParameters> {
  final BaseHotelRepository baseHotelRepository;

  GetHotelFavoriteUsecase(this.baseHotelRepository);
  @override
  Future<Either<Failure, List<Hotel>>> call(NoParameters parameters) async {
    return await baseHotelRepository.getHotelFavorite();
  }
}
