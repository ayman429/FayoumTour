import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../../repository/base_post_repository.dart';

class GetLikeUsecase {
  // extends BaseUseCase<TourismPlaceRate, String>
  final BasePostRepository basePostRepository;

  GetLikeUsecase(this.basePostRepository);
  Future<Either<Failure, String>> call(int postId, int userId) async {
    return await basePostRepository.getLike(postId, userId);
  }
}
