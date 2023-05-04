import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../data/models/hotel_model.dart';
import '../entities/hotel.dart';
import '../repository/base_hotel_repository.dart';

class AddHotelUsecase extends BaseUseCase<Unit, Hotel> {
  final BaseHotelRepository baseHotelRepository;

  AddHotelUsecase(this.baseHotelRepository);
  @override
  Future<Either<Failure, Unit>> call(Hotel parameters) async {
    HotelModel hotelModel = HotelModel.castFromEntity(parameters);
    return await baseHotelRepository.addHotel(hotelModel);
  }
}
