import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../entities/post_data.dart';
import '../repository/base_post_repository.dart';

class AddPostUsecase {
  // extends BaseUseCase<Unit, Post>
  final BasePostRepository basePostRepository;

  AddPostUsecase(this.basePostRepository);
  @override
  Future<Either<Failure, Unit>> call(PostData postData) async {
    // PostModel postModel = PostModel.castFromEntity(parameters);
    return await basePostRepository.addPost(postData);
  }
}
