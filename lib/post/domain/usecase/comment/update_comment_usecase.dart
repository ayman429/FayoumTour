import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../../data/models/comment_model.dart';
import '../../entities/comment.dart';
import '../../repository/base_post_repository.dart';

class UpdateCommentUsecase extends BaseUseCase<Unit, Comment> {
  final BasePostRepository basePostRepository;

  UpdateCommentUsecase(this.basePostRepository);
  @override
  Future<Either<Failure, Unit>> call(Comment parameters) async {
    CommentModel commentModel = CommentModel.castFromEntity(parameters);
    return await basePostRepository.updateComment(commentModel);
  }
}
