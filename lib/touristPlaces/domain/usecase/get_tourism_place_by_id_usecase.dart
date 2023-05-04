import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/tourism_place.dart';
import '../repository/base_tourism_place_repository.dart';

class GetTourismPlaceByIdUsecase extends BaseUseCase<TourismPlace, String> {
  final BaseTourismPlaceRepository baseTourismPlaceRepository;

  GetTourismPlaceByIdUsecase(this.baseTourismPlaceRepository);
  @override
  Future<Either<Failure, TourismPlace>> call(String parameters) async {
    return await baseTourismPlaceRepository.getTourismPlaceById(parameters);
  }
}
