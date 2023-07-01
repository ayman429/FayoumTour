import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/tourism_place.dart';
import '../repository/base_tourism_place_repository.dart';

class Model1Usecase extends BaseUseCase<List<TourismPlace>, String> {
  final BaseTourismPlaceRepository baseTourismPlaceRepository;

  Model1Usecase(this.baseTourismPlaceRepository);
  @override
  Future<Either<Failure, List<TourismPlace>>> call(String parameters) async {
    return await baseTourismPlaceRepository.model1(parameters);
  }
}
