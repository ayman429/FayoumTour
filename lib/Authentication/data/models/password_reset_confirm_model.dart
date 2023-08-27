// ignore_for_file: non_constant_identifier_names

import '../../domain/entities/password_reset_confirm.dart';

class PasswordResetConfirmModel extends PasswordResetConfirm {
  const PasswordResetConfirmModel(
      {required String new_password1,
      required String new_password2,
      required String link})
      : super(
            new_password1: new_password1,
            new_password2: new_password2,
            link: link);
  PasswordResetConfirmModel.castFromEntity(
      final PasswordResetConfirm passwordResetConfirm)
      : super(
            new_password1: passwordResetConfirm.new_password1,
            new_password2: passwordResetConfirm.new_password2,
            link: passwordResetConfirm.link);
}
