import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../data/models/post_model.dart';
import '../entities/post.dart';

abstract class BasePostRepository {
  Future<Either<Failure, List<Post>>> getPost();
  Future<Either<Failure, Post>> getPostById(String iD);
  Future<Either<Failure, String>> deletePost(String iD);
  Future<Either<Failure, Unit>> addPost(PostModel postModel);
  Future<Either<Failure, Unit>> updatePost(PostModel postModel);

  // Future<Either<Failure, List<Post>>> searchByField(String search);
  // Future<Either<Failure, List<Post>>> orderingByField(search);

}