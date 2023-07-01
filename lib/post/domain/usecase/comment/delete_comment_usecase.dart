import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_post_repository.dart';

class DeleteCommentUsecase extends BaseUseCase<String, String> {
  final BasePostRepository basePostRepository;

  DeleteCommentUsecase(this.basePostRepository);
  @override
  Future<Either<Failure, String>> call(String parameters) async {
    return await basePostRepository.deleteComment(parameters);
  }
}
