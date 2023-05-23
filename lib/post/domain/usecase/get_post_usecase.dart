import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/post.dart';
import '../repository/base_post_repository.dart';

class GetPostUsecase extends BaseUseCase<List<Post>, NoParameters> {
  final BasePostRepository basePostRepository;

  GetPostUsecase(this.basePostRepository);
  @override
  Future<Either<Failure, List<Post>>> call(NoParameters parameters) async {
    return await basePostRepository.getPost();
  }
}
