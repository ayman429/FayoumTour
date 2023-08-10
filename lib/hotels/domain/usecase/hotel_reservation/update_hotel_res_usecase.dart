import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../data/models/hotel_reservation_model.dart';
import '../../entities/hotel_reservation.dart';
import '../../repository/base_hotel_repository.dart';

class UpdateHotelReservationByUserUsecase {
  //extends BaseUseCase<Unit, HotelReservation>
  final BaseHotelRepository baseHotelRepository;

  UpdateHotelReservationByUserUsecase(this.baseHotelRepository);
  @override
  Future<Either<Failure, Unit>> call(
      HotelReservation parameters, String reservationId) async {
    HotelReservationModel hotelReservationModel =
        HotelReservationModel.castFromEntity(parameters);
    return await baseHotelRepository.updateHotelReservationByUser(
        hotelReservationModel, reservationId);
  }
}
