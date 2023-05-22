import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../data/models/hotel_rate_model.dart';
import '../../entities/hotel_rate.dart';
import '../../repository/base_hotel_repository.dart';

class UpdateCreateHotelRateUsecase {
  final BaseHotelRepository baseHotelRepository;

  UpdateCreateHotelRateUsecase(this.baseHotelRepository);
  Future<Either<Failure, Unit>> call(
      HotelRate hotelRate, String hotelID) async {
    HotelRateModel hotelRateModel = HotelRateModel.castFromEntity(hotelRate);
    return await baseHotelRepository.addHotelRate(hotelRateModel, hotelID);
  }
}
