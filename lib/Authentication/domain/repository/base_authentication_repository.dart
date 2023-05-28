import 'package:dartz/dartz.dart';
import 'package:fayoumtour/Authentication/data/models/user_details_model.dart';

import '../../../core/error/faliure.dart';
import '../../data/models/change_password_model.dart';
import '../../data/models/login_model.dart';
import '../../data/models/password_reset_confirm_model.dart';
import '../../data/models/registration_model.dart';
import '../../data/models/reset_password_model.dart';
import '../entities/user_details.dart';

abstract class BaseAuthenticationRepository {
  Future<Either<Failure, UserDetails>> getUserDetails();
  Future<Either<Failure, String>> updateUserDetails(String userName);
  Future<Either<Failure, Unit>> registration(
      RegistrationModel registrationModel);
  Future<Either<Failure, Unit>> login(LoginModel loginModel);
  Future<Either<Failure, dynamic>> logout();
  Future<Either<Failure, Unit>> changepassword(
      ChangePasswordModel changePasswordModel);

  Future<Either<Failure, Unit>> resetpassword(
      ResetPasswordModel resetPasswordModel);
  Future<Either<Failure, Unit>> passwordresetconfirm(
      PasswordResetConfirmModel passwordResetModel);
}
