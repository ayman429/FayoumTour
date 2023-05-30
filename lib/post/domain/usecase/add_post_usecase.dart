import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../data/models/post_model.dart';
import '../entities/post.dart';
import '../repository/base_post_repository.dart';

class AddPostUsecase {
  // extends BaseUseCase<Unit, Post>
  final BasePostRepository baseHotelRepository;

  AddPostUsecase(this.baseHotelRepository);
  @override
  Future<Either<Failure, Unit>> call(String body, List<String> images) async {
    // PostModel postModel = PostModel.castFromEntity(parameters);
    return await baseHotelRepository.addPost(body, images);
  }
}
