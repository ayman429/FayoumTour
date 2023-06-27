import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_hotel_repository.dart';

class DeleteHotelReservationUsecase extends BaseUseCase<String, String> {
  final BaseHotelRepository baseHotelRepository;

  DeleteHotelReservationUsecase(this.baseHotelRepository);
  @override
  Future<Either<Failure, String>> call(String parameters) async {
    return await baseHotelRepository.deleteHotelReservation(parameters);
  }
}
