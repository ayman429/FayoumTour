import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../data/models/login_model.dart';
import '../entities/login.dart';
import '../repository/base_authentication_repository.dart';

class LoginUsecase extends BaseUseCase<Unit, Login> {
  final BaseAuthenticationRepository baseAuthenticationRepository;

  LoginUsecase(this.baseAuthenticationRepository);

  @override
  Future<Either<Failure, Unit>> call(Login parameters) async {
    LoginModel loginModel = LoginModel.castFromEntity(parameters);
    return await baseAuthenticationRepository.login(loginModel);
  }
}
