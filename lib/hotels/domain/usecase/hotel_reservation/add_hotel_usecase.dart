import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../../data/models/hotel_reservation_model.dart';
import '../../entities/hotel_reservation.dart';
import '../../repository/base_hotel_repository.dart';

class AddHotelReservationUsecase extends BaseUseCase<Unit, HotelReservation> {
  final BaseHotelRepository baseHotelRepository;

  AddHotelReservationUsecase(this.baseHotelRepository);
  @override
  Future<Either<Failure, Unit>> call(HotelReservation parameters) async {
    HotelReservationModel hotelReservationModel =
        HotelReservationModel.castFromEntity(parameters);
    return await baseHotelRepository.addHotelReservation(hotelReservationModel);
  }
}
