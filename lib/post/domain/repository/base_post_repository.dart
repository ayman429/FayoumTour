import 'package:dartz/dartz.dart';
import 'package:fayoumtour/post/data/models/comment_model.dart';

import '../../../core/error/faliure.dart';
import '../../data/models/like_model.dart';
import '../entities/comment.dart';
import '../entities/like.dart';
import '../entities/post.dart';

abstract class BasePostRepository {
  Future<Either<Failure, List<Post>>> getPost();
  Future<Either<Failure, Post>> getPostById(String iD);
  Future<Either<Failure, String>> deletePost(String iD);
  Future<Either<Failure, Unit>> addPost(String body, List<String> images);
  Future<Either<Failure, Unit>> updatePost(
      String body, List<String> images, String posId, String index);

  // Future<Either<Failure, List<Post>>> searchByField(String search);
  // Future<Either<Failure, List<Post>>> orderingByField(search);

  // Comment
  Future<Either<Failure, List<Comment>>> getComment(int postId);
  Future<Either<Failure, String>> deleteComment(String id);
  Future<Either<Failure, Unit>> addComment(CommentModel comment);
  Future<Either<Failure, Unit>> updateComment(CommentModel comment);

  // Like
  Future<Either<Failure, String>> getLike(int postId, int userId);
  Future<Either<Failure, Unit>> addLike(LikeModel likeModel);
}
