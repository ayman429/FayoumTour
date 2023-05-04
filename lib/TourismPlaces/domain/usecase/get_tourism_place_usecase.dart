import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/tourism_place.dart';
import '../repository/base_tourism_place_repository.dart';

class GetTourismPlaceUsecase
    extends BaseUseCase<List<TourismPlace>, NoParameters> {
  final BaseTourismPlaceRepository baseTourismPlaceRepository;

  GetTourismPlaceUsecase(this.baseTourismPlaceRepository);
  @override
  Future<Either<Failure, List<TourismPlace>>> call(
      NoParameters parameters) async {
    return await baseTourismPlaceRepository.getTourismPlace();
  }
}
