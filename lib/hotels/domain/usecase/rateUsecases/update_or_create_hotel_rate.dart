import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../data/models/hotel_rate_model.dart';
import '../../repository/base_hotel_repository.dart';

class UpdateCreateHotelRateUsecase {
  final BaseHotelRepository baseHotelRepository;

  UpdateCreateHotelRateUsecase(this.baseHotelRepository);
  Future<Either<Failure, Unit>> call(
      HotelRateModel hotelRateModel, String HotelID) async {
    return await baseHotelRepository.updateCreateHotelRate(
        hotelRateModel, HotelID);
  }
}
