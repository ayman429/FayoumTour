import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../entities/comment.dart';
import '../../repository/base_post_repository.dart';

class GetCommentUsecase extends BaseUseCase<List<Comment>, int> {
  final BasePostRepository basePostRepository;

  GetCommentUsecase(this.basePostRepository);
  @override
  Future<Either<Failure, List<Comment>>> call(int parameters) async {
    return await basePostRepository.getComment(parameters);
  }
}
