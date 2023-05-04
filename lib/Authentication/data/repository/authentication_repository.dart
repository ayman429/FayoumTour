import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/faliure.dart';
import '../../domain/entities/user_details.dart';
import '../../domain/repository/base_authentication_repository.dart';
import '../datasource/authentication_remote_data_source.dart';
import '../models/change_password_model.dart';
import '../models/login_model.dart';
import '../models/password_reset_confirm_model.dart';
import '../models/registration_model.dart';
import '../models/reset_password_model.dart';

class AuthenticationRerpository extends BaseAuthenticationRepository {
  final BaseAuthenticationRemoteDataSource baseAuthenticationRemoteDataSource;
  // final BaseAuthenticationLocalDataSource baseAuthenticationLocalDataSource;
  AuthenticationRerpository(
    this.baseAuthenticationRemoteDataSource,
    // this.baseAuthenticationLocalDataSource,
  );

  @override
  Future<Either<Failure, UserDetails>> getUserDetails() async {
    try {
      final result = await baseAuthenticationRemoteDataSource.getUsersDetails();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> registration(
      RegistrationModel registrationModel) async {
    try {
      final add = await baseAuthenticationRemoteDataSource
          .registration(registrationModel);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> login(LoginModel loginModel) async {
    try {
      final add = await baseAuthenticationRemoteDataSource.logIn(loginModel);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      final result = await baseAuthenticationRemoteDataSource.logOut();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> changepassword(
      ChangePasswordModel changePasswordModel) async {
    try {
      final add = await baseAuthenticationRemoteDataSource
          .changePassword(changePasswordModel);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> resetpassword(
      ResetPasswordModel resetPasswordModel) async {
    try {
      final add = await baseAuthenticationRemoteDataSource
          .resetPassword(resetPasswordModel);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> passwordresetconfirm(
      PasswordResetConfirmModel passwordResetConfirmModel) async {
    try {
      final add = await baseAuthenticationRemoteDataSource
          .passwordResetConfirm(passwordResetConfirmModel);
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }
}
