import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../repository/base_hotel_repository.dart';

class GetHotelRateByUserUsecase {
  // extends BaseUseCase<TourismPlaceRate, String>
  final BaseHotelRepository baseHotelRepository;

  GetHotelRateByUserUsecase(this.baseHotelRepository);
  Future<Either<Failure, String>> call(int hotelId, int userId) async {
    return await baseHotelRepository.getHotelRateByUser(hotelId, userId);
  }
}
