import '../../domain/entities/reset_password.dart';

class ResetPasswordModel extends ResetPassword {
  const ResetPasswordModel({required String email}) : super(email: email);
  ResetPasswordModel.castFromEntity(final ResetPassword resetPassword)
      : super(email: resetPassword.email);
}
