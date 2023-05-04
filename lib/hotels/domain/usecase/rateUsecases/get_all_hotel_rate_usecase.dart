import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../entities/hotel_rate.dart';
import '../../repository/base_hotel_repository.dart';

class GetHotelRateUsecase extends BaseUseCase<List<HotelRate>, NoParameters> {
  final BaseHotelRepository baseHotelRepository;

  GetHotelRateUsecase(this.baseHotelRepository);
  @override
  Future<Either<Failure, List<HotelRate>>> call(NoParameters parameters) async {
    return await baseHotelRepository.getHotelRate();
  }
}
