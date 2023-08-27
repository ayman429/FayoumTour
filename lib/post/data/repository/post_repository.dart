// ignore_for_file: avoid_renaming_method_parameters, non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:fayoumtour/post/data/models/comment_model.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/faliure.dart';
import '../../domain/entities/comment.dart';
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
  Future<Either<Failure, Unit>> addPost(postData) async {
    final add = await basePostRemoteDataSource.addPosts(postData);
    try {
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(body, images, posId, index) async {
    final add =
        await basePostRemoteDataSource.updatePosts(body, images, posId, index);
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

  // comment

  @override
  Future<Either<Failure, List<Comment>>> getComment(postId) async {
    final result = await basePostRemoteDataSource.getComments(postId);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> addComment(comment) async {
    final add = await basePostRemoteDataSource.addComments(comment);
    try {
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateComment(CommentModel comment) async {
    final add = await basePostRemoteDataSource.updateComments(comment);
    try {
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, String>> deleteComment(id) async {
    final result = await basePostRemoteDataSource.deleteComments(id);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  // Like
  @override
  Future<Either<Failure, Unit>> addLike(likeModel) async {
    final add = await basePostRemoteDataSource.addLikes(likeModel);
    try {
      return Right(add);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMassage));
    }
  }

  @override
  Future<Either<Failure, String>> getLike(postId, userId) async {
    final add = await basePostRemoteDataSource.getLikes(postId, userId);
    try {
      return Right(add);
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
