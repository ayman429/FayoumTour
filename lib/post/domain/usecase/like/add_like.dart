import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../data/models/like_model.dart';
import '../../entities/like.dart';
import '../../repository/base_post_repository.dart';

class AddLikeUsecase {
  final BasePostRepository basePostRepository;

  AddLikeUsecase(this.basePostRepository);
  Future<Either<Failure, Unit>> call(Like parameters) async {
    LikeModel likeModel = LikeModel.castFromEntity(parameters);
    return await basePostRepository.addLike(likeModel);
  }
}
