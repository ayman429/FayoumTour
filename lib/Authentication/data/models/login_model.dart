import '../../domain/entities/login.dart';

class LoginModel extends Login {
  LoginModel({required String email, required String password})
      : super(email: email, password: password);

  LoginModel.castFromEntity(final Login login)
      : super(email: login.email, password: login.password);
}
