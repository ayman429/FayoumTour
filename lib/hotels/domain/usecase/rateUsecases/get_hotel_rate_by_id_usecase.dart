import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../entities/hotel_rate.dart';
import '../../repository/base_hotel_repository.dart';

class GetHotelRateByIdUsecase extends BaseUseCase<HotelRate, String> {
  final BaseHotelRepository baseHotelRepository;

  GetHotelRateByIdUsecase(this.baseHotelRepository);
  @override
  Future<Either<Failure, HotelRate>> call(String parameters) async {
    return await baseHotelRepository.getHotelRateById(parameters);
  }
}
