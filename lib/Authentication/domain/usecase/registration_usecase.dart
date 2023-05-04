import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../data/models/registration_model.dart';
import '../entities/registration.dart';
import '../repository/base_authentication_repository.dart';

class RegisterationUsecase extends BaseUseCase<Unit, Registration> {
  final BaseAuthenticationRepository baseAuthenticationRepository;

  RegisterationUsecase(this.baseAuthenticationRepository);
  @override
  Future<Either<Failure, Unit>> call(Registration parameters) async {
    RegistrationModel registrationModel =
        RegistrationModel.castFromEntity(parameters);
    return await baseAuthenticationRepository.registration(registrationModel);
  }
}
