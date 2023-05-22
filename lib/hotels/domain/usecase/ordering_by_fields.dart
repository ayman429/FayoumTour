import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/hotel.dart';
import '../repository/base_hotel_repository.dart';

class OrderingHotelByFieldsUsecase extends BaseUseCase<List<Hotel>, String> {
  final BaseHotelRepository baseHotelRepository;

  OrderingHotelByFieldsUsecase(this.baseHotelRepository);
  @override
  Future<Either<Failure, List<Hotel>>> call(String parameters) async {
    return await baseHotelRepository.orderingByField(parameters);
  }
}
