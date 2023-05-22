import 'package:dartz/dartz.dart';
import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../data/models/change_password_model.dart';
import '../entities/change_password.dart';
import '../repository/base_authentication_repository.dart';

class ChangePasswordUsecase extends BaseUseCase<Unit, ChangePassword> {
  final BaseAuthenticationRepository baseAuthenticationRepository;

  ChangePasswordUsecase(this.baseAuthenticationRepository);

  @override
  Future<Either<Failure, Unit>> call(ChangePassword parameters) async {
    ChangePasswordModel changePassworModel =
        ChangePasswordModel.castFromEntity(parameters);
    return await baseAuthenticationRepository
        .changepassword(changePassworModel);
  }
}
