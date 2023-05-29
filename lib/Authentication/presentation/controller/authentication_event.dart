import '../../domain/entities/change_password.dart';
import '../../domain/entities/login.dart';
import '../../domain/entities/password_reset_confirm.dart';
import '../../domain/entities/registration.dart';
import '../../domain/entities/reset_password.dart';
import '../../domain/entities/user_details.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class GetUserDetailsEvent extends AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  Login login;
  LoginEvent({
    required this.login,
  });
}

class RegistrationEvent extends AuthenticationEvent {
  Registration registration;
  RegistrationEvent({
    required this.registration,
  });
}

class UpdateUserDetailsEvent extends AuthenticationEvent {
  var userData;
  String type;
  UpdateUserDetailsEvent({
    required this.userData,
    required this.type,
  });
}

class ChangePasswordEvent extends AuthenticationEvent {
  ChangePassword changePassword;
  ChangePasswordEvent({
    required this.changePassword,
  });
}

class ResetPasswordEvent extends AuthenticationEvent {
  ResetPassword resetPassword;
  ResetPasswordEvent({
    required this.resetPassword,
  });
}

class ResetPasswordConfirmEvent extends AuthenticationEvent {
  PasswordResetConfirm resetConfirm;
  ResetPasswordConfirmEvent({
    required this.resetConfirm,
  });
}

class LogoutEvent extends AuthenticationEvent {}
