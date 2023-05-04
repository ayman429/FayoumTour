import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../data/models/tourism_place_model.dart';
import '../entities/tourism_place.dart';
import '../repository/base_tourism_place_repository.dart';

class UpdateTourismPlaceUsecase extends BaseUseCase<Unit, TourismPlace> {
  final BaseTourismPlaceRepository baseTourismPlaceRepository;

  UpdateTourismPlaceUsecase(this.baseTourismPlaceRepository);
  @override
  Future<Either<Failure, Unit>> call(TourismPlace parameters) async {
    TourismPlaceModel tourismPlaceModel =
        TourismPlaceModel.castFromEntity(parameters);
    return await baseTourismPlaceRepository.addTourismPlace(tourismPlaceModel);
  }
}
