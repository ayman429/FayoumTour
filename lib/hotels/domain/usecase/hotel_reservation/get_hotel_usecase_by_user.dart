import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../entities/hotel_reservation.dart';
import '../../repository/base_hotel_repository.dart';

class GetHotelReservationByUserUsecase
    extends BaseUseCase<List<HotelReservation>, int> {
  final BaseHotelRepository baseHotelRepository;

  GetHotelReservationByUserUsecase(this.baseHotelRepository);
  @override
  Future<Either<Failure, List<HotelReservation>>> call(int parameters) async {
    return await baseHotelRepository.getHotelReservationByUser(parameters);
  }
}
