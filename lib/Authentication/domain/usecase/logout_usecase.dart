import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../repository/base_authentication_repository.dart';

class Logout extends BaseUseCase<Unit, NoParameters> {
  final BaseAuthenticationRepository baseAuthenticationRepositor;

  Logout(this.baseAuthenticationRepositor);
  @override
  Future<Either<Failure, Unit>> call(NoParameters parameters) async {
    return await baseAuthenticationRepositor.logout();
  }
}
