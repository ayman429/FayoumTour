import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../repository/base_tourism_place_repository.dart';

class DeleteTourismPlaceUsecase extends BaseUseCase<String, String> {
  final BaseTourismPlaceRepository baseTourismPlaceRepository;

  DeleteTourismPlaceUsecase(this.baseTourismPlaceRepository);
  @override
  Future<Either<Failure, String>> call(String parameters) async {
    return await baseTourismPlaceRepository.deleteTourismPlace(parameters);
  }
}
