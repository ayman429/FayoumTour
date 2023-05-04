import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../data/models/reset_password_model.dart';
import '../repository/base_authentication_repository.dart';

class ResetPasswordUsecase extends BaseUseCase<Unit, ResetPasswordModel> {
  final BaseAuthenticationRepository baseAuthenticationRepository;

  ResetPasswordUsecase(this.baseAuthenticationRepository);

  @override
  Future<Either<Failure, Unit>> call(ResetPasswordModel parameters) async {
    return await baseAuthenticationRepository.resetpassword(parameters);
  }
}
