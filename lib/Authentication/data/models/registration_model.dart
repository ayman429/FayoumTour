import '../../domain/entities/registration.dart';

class RegistrationModel extends Registration {
  const RegistrationModel(
      {required String username,
      required String email,
      required String password1,
      required String password2})
      : super(
            username: username,
            email: email,
            password1: password1,
            password2: password2);
  RegistrationModel.castFromEntity(final Registration registration)
      : super(
            username: registration.username,
            email: registration.email,
            password1: registration.password1,
            password2: registration.password2);
}
