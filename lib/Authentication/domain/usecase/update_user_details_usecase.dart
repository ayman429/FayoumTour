import 'package:dartz/dartz.dart';
import 'package:fayoumtour/Authentication/data/models/user_details_model.dart';

import '../../../core/error/faliure.dart';
import '../entities/user_details.dart';
import '../repository/base_authentication_repository.dart';

class UpdateUserDetailsUsecase {
  // extends BaseUseCase<String, String>
  final BaseAuthenticationRepository baseAuthenticationRepository;

  UpdateUserDetailsUsecase(this.baseAuthenticationRepository);
  
  Future<Either<Failure, String>> call(
      UserDetails userData, String type) async {
    UserDetailsModel userDetailsModel =
        UserDetailsModel.castFromEntity(userData);
    return await baseAuthenticationRepository.updateUserDetails(
        userDetailsModel, type);
  }
}
