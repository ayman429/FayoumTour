import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/tourism_place.dart';
import '../repository/base_tourism_place_repository.dart';

class SearchByRateUsecase extends BaseUseCase<List<TourismPlace>, int> {
  final BaseTourismPlaceRepository baseTourismPlaceRepository;

  SearchByRateUsecase(this.baseTourismPlaceRepository);
  @override
  Future<Either<Failure, List<TourismPlace>>> call(int parameters) async {
    return await baseTourismPlaceRepository.searchByRate(parameters);
  }
}
