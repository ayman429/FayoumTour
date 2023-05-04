import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/hotel.dart';
import '../repository/base_hotel_repository.dart';

class GetHotelByIdUsecase extends BaseUseCase<Hotel, String> {
  final BaseHotelRepository baseHotelRepository;

  GetHotelByIdUsecase(this.baseHotelRepository);
  @override
  Future<Either<Failure, Hotel>> call(String parameters) async {
    return await baseHotelRepository.getHotelById(parameters);
  }
}
