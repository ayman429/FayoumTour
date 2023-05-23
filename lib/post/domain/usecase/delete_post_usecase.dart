import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../repository/base_post_repository.dart';

class DeletePostUsecase extends BaseUseCase<String, String> {
  final BasePostRepository basePostRepository;

  DeletePostUsecase(this.basePostRepository);
  @override
  Future<Either<Failure, String>> call(String parameters) async {
    return await basePostRepository.deletePost(parameters);
  }
}
