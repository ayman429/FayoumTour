import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/hotel.dart';
import '../repository/base_hotel_repository.dart';

class OrderingByFieldsUsecase extends BaseUseCase<List<Hotel>, String> {
  final BaseHotelRepository baseHotelRepository;

  OrderingByFieldsUsecase(this.baseHotelRepository);
  @override
  Future<Either<Failure, List<Hotel>>> call(String parameters) async {
    return await baseHotelRepository.orderingByField(parameters);
  }
}
