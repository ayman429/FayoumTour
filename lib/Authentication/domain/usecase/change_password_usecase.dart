import 'package:dartz/dartz.dart';
import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../data/models/change_password_model.dart';
import '../repository/base_authentication_repository.dart';

class ChangePasswordUsecase extends BaseUseCase<Unit, ChangePasswordModel> {
  final BaseAuthenticationRepository baseAuthenticationRepository;

  ChangePasswordUsecase(this.baseAuthenticationRepository);

  @override
  Future<Either<Failure, Unit>> call(ChangePasswordModel parameters) async {
    return await baseAuthenticationRepository.changepassword(parameters);
  }
}
