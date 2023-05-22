import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../data/models/password_reset_confirm_model.dart';
import '../entities/password_reset_confirm.dart';
import '../repository/base_authentication_repository.dart';

class ResetPasswordConfirmUsecase
    extends BaseUseCase<Unit, PasswordResetConfirm> {
  final BaseAuthenticationRepository baseAuthenticationRepository;

  ResetPasswordConfirmUsecase(this.baseAuthenticationRepository);

  @override
  Future<Either<Failure, Unit>> call(PasswordResetConfirm parameters) async {
    PasswordResetConfirmModel passwordResetConfirmModel =
        PasswordResetConfirmModel.castFromEntity(parameters);
    return await baseAuthenticationRepository
        .passwordresetconfirm(passwordResetConfirmModel);
  }
}
