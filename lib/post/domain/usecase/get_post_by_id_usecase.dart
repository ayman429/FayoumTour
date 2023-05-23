import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/post.dart';
import '../repository/base_post_repository.dart';

class GetPostByIdUsecase extends BaseUseCase<Post, String> {
  final BasePostRepository basePostRepository;

  GetPostByIdUsecase(this.basePostRepository);
  @override
  Future<Either<Failure, Post>> call(String parameters) async {
    return await basePostRepository.getPostById(parameters);
  }
}
