import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../repository/base_authentication_repository.dart';

class LogoutUsecase extends BaseUseCase<dynamic, NoParameters> {
  final BaseAuthenticationRepository baseAuthenticationRepositor;

  LogoutUsecase(this.baseAuthenticationRepositor);
  @override
  Future<Either<Failure, dynamic>> call(NoParameters parameters) async {
    return await baseAuthenticationRepositor.logout();
  }
}
