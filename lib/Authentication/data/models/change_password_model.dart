import '../../domain/entities/change_password.dart';

class ChangePasswordModel extends ChangePassword {
  ChangePasswordModel(
      {required String new_password1, required String new_password2})
      : super(new_password1: new_password1, new_password2: new_password2);

  ChangePasswordModel.castFromEntity(final ChangePassword changePassword)
      : super(
            new_password1: changePassword.new_password1,
            new_password2: changePassword.new_password2);
}
