import 'package:dartz/dartz.dart';
import 'package:fayoumtour/Authentication/data/models/user_details_model.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/user_details.dart';
import '../repository/base_authentication_repository.dart';

class UpdateUserDetailsUsecase extends BaseUseCase<UserDetails, UserDetails> {
  final BaseAuthenticationRepository baseAuthenticationRepository;

  UpdateUserDetailsUsecase(this.baseAuthenticationRepository);
  @override
  Future<Either<Failure, UserDetails>> call(UserDetails parameters) async {
    UserDetailsModel userDetailsModel =
        UserDetailsModel.castFromEntity(parameters);
    return await baseAuthenticationRepository
        .updateUserDetails(userDetailsModel);
  }
}
