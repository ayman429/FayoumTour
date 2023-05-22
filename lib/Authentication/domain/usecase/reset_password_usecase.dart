import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../data/models/reset_password_model.dart';
import '../entities/reset_password.dart';
import '../repository/base_authentication_repository.dart';

class ResetPasswordUsecase extends BaseUseCase<Unit, ResetPassword> {
  final BaseAuthenticationRepository baseAuthenticationRepository;

  ResetPasswordUsecase(this.baseAuthenticationRepository);

  @override
  Future<Either<Failure, Unit>> call(ResetPassword parameters) async {
    ResetPasswordModel resetPasswordModel =
        ResetPasswordModel.castFromEntity(parameters);
    return await baseAuthenticationRepository.resetpassword(resetPasswordModel);
  }
}
