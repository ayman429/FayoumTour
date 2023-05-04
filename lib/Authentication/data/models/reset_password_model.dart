import '../../domain/entities/reset_password.dart';

class ResetPasswordModel extends ResetPassword {
  ResetPasswordModel({required String email}) : super(email: email);
  ResetPasswordModel.castFromEntity(final ResetPassword resetPassword)
      : super(email: resetPassword.email);
}
