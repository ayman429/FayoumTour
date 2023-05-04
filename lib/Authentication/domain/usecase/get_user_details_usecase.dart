import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/user_details.dart';
import '../repository/base_authentication_repository.dart';

class GetUserDetailsUsecase extends BaseUseCase<UserDetails, NoParameters> {
  final BaseAuthenticationRepository baseAuthenticationRepository;

  GetUserDetailsUsecase(this.baseAuthenticationRepository);
  @override
  Future<Either<Failure, UserDetails>> call(NoParameters parameters) async {
    return await baseAuthenticationRepository.getUserDetails();
  }
}
