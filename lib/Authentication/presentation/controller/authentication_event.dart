import '../../domain/entities/login.dart';
import '../../domain/entities/registration.dart';

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

class LogoutEvent extends AuthenticationEvent {}
