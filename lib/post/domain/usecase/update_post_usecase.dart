import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../data/models/post_model.dart';
import '../entities/post.dart';
import '../repository/base_post_repository.dart';

class UpdatePostUsecase {
  //extends BaseUseCase<Unit, Post>
  final BasePostRepository basePostRepository;

  UpdatePostUsecase(this.basePostRepository);
  @override
  Future<Either<Failure, Unit>> call(
      String body, List<String> images, String posId, String index) async {
    // PostModel postModel = PostModel.castFromEntity(parameters);
    return await basePostRepository.updatePost(body, images, posId, index);
  }
}
