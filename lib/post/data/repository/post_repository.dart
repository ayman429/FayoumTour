import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/faliure.dart';
import '../../domain/entities/post.dart';
import '../../domain/repository/base_post_repository.dart';
import '../datasource/post_remote_data_source.dart';

class PostRerpository extends BasePostRepository {
  final BasePostRemoteDataSource basePostRemoteDataSource;
  PostRerpository(
    this.basePostRemoteDataSource,
  );

  @override
  Future<Either<Failure, List<Post>>> getPost() async {
    final result = await basePostRemoteDataSource.getPosts();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(body, images) async {
    final add = await basePostRemoteDataSource.addPosts(body, images);
    try {
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(body, images, posId) async {
    final add = await basePostRemoteDataSource.updatePosts(body, images, posId);
    try {
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, String>> deletePost(iD) async {
    final result = await basePostRemoteDataSource.deletePosts(iD);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Post>> getPostById(ID) async {
    final result = await basePostRemoteDataSource.getPostsById(ID);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  // @override
  // Future<Either<Failure, List<Post>>> searchByField(search) async {
  //   final result = await basePostRemoteDataSource.searchByFields(search);

  //   try {
  //     return Right(result);
  //   } on ServerException catch (failure) {
  //     return Left(ServerFailure(failure.errorMassageModel.statusMassage));
  //   }
  // }

  // @override
  // Future<Either<Failure, List<Post>>> orderingByField(search) async {
  //   final result = await basePostRemoteDataSource.orderingByFields(search);

  //   try {
  //     return Right(result);
  //   } on ServerException catch (failure) {
  //     return Left(ServerFailure(failure.errorMassageModel.statusMassage));
  //   }
  // }

}
