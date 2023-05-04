import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../data/models/password_reset_confirm_model.dart';
import '../repository/base_authentication_repository.dart';

class PasswordResetConfirmUsecase
    extends BaseUseCase<Unit, PasswordResetConfirmModel> {
  final BaseAuthenticationRepository baseAuthenticationRepository;

  PasswordResetConfirmUsecase(this.baseAuthenticationRepository);

  @override
  Future<Either<Failure, Unit>> call(
      PasswordResetConfirmModel parameters) async {
    return await baseAuthenticationRepository.passwordresetconfirm(parameters);
  }
}
