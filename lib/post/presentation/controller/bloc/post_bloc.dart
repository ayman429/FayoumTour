import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/entities/comment.dart';
import '../../../domain/entities/like.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecase/add_post_usecase.dart';
import '../../../domain/usecase/comment/add_comment_usecase.dart';
import '../../../domain/usecase/comment/delete_comment_usecase.dart';
import '../../../domain/usecase/comment/get_comment_usecase.dart';
import '../../../domain/usecase/comment/update_comment_usecase.dart';
import '../../../domain/usecase/delete_post_usecase.dart';
import '../../../domain/usecase/get_post_by_id_usecase.dart';
import '../../../domain/usecase/get_post_usecase.dart';
import '../../../domain/usecase/like/add_like.dart';
import '../../../domain/usecase/like/get_like.dart';
import '../../../domain/usecase/update_post_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

Map<int, int> likeMap = {};

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostUsecase getPostUsecase;
  final GetPostByIdUsecase getPostByIdUsecase;

  final AddPostUsecase addPostUsecase;
  final UpdatePostUsecase updatePostUsecase;
  final DeletePostUsecase deletePostUsecase;

  // Comment
  final GetCommentUsecase getCommentUsecase;
  final AddCommentUsecase addCommentUsecase;
  final UpdateCommentUsecase updateCommentUsecase;
  final DeleteCommentUsecase deleteCommentUsecase;

  // Like
  final GetLikeUsecase getLikeUsecase;
  final AddLikeUsecase addLikeUsecase;
  // final OrderingPostByFieldsUsecase orderingPostByFieldsUsecase;
  // final SearchByFieldsPostUsecase searchPostByFieldsUsecase;
  PostBloc(
    // this.orderingPostByFieldsUsecase,
    // this.searchPostByFieldsUsecase,
    // this.searchPostByRateUsecase,
    this.getPostUsecase,
    this.getPostByIdUsecase,
    this.addPostUsecase,
    this.updatePostUsecase,
    this.deletePostUsecase,
    this.getCommentUsecase,
    this.addCommentUsecase,
    this.updateCommentUsecase,
    this.deleteCommentUsecase,
    this.getLikeUsecase,
    this.addLikeUsecase,
  ) : super(PostState()) {
    on<GetPostEvent>(_getPost);
    on<GetPostByIdEvent>(_getPostById);
    on<AddPostEvent>(_addPost);
    on<UpdatePostEvent>(_updatePost);
    on<DeletePostEvent>(_deletePost);
    // Comment
    on<GetCommentEvent>(_getComment);
    on<AddCommentEvent>(_addComment);
    on<UpdateCommentEvent>(_updateComment);
    on<DeleteCommentEvent>(_deleteComment);

    // Like
    on<GetLikeEvent>(_getLike);
    on<AddLikeEvent>(_addLike);

    // on<OrderingPostByFieldsEvent>(_orderingPostByFields);
    // on<SearchPostByFieldsEvent>(_searchPostByFields);
  }

  FutureOr<void> _getPost(GetPostEvent event, Emitter<PostState> emit) async {
    // emit(PostState(postState: RequestState.loading));
    try {
      (await getPostUsecase(const NoParameters())).fold((l) {
        return emit(
            PostState(postState: RequestState.error, postMessage: l.message));
      }, (r) {
        // print(r);

        return emit(PostState(
          post: r,
          postState: RequestState.loaded,
        ));
      });
    } catch (e) {
      print("l.message ${e}");
      return emit(PostState(
          postState: RequestState.error, postMessage: "No Connection"));
    }
  }

  FutureOr<void> _getPostById(
      GetPostByIdEvent event, Emitter<PostState> emit) async {
    (await getPostByIdUsecase(event.postId)).fold((l) {
      return emit(PostState(
          postStateById: RequestState.error, postMessageById: l.message));
    }, (r) {
      return emit(PostState(
        postById: r,
        postStateById: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _addPost(AddPostEvent event, Emitter<PostState> emit) async {
    try {
      (await addPostUsecase(event.body, event.images)).fold((l) {
        return emit(PostState(
            addPostState: RequestState.error, addPostMessage: l.message));
      }, (r) {
        return emit(PostState(
          addPostState: RequestState.loaded,
        ));
      });
    } catch (e) {
      return emit(PostState(
          addPostState: RequestState.error, addPostMessage: "No Connection"));
    }
  }

  FutureOr<void> _updatePost(
      UpdatePostEvent event, Emitter<PostState> emit) async {
    try {
      (await updatePostUsecase(
              event.body, event.images, event.posId, event.index))
          .fold((l) {
        return emit(PostState(
            updatePostState: RequestState.error, updatePostMessage: l.message));
      }, (r) {
        return emit(PostState(
          updatePostState: RequestState.loaded,
        ));
      });
    } catch (e) {
      return emit(PostState(
          addPostState: RequestState.error, addPostMessage: "No Connection"));
    }
  }

  FutureOr<void> _deletePost(
      DeletePostEvent event, Emitter<PostState> emit) async {
    (await deletePostUsecase(event.postId)).fold((l) {
      return emit(PostState(
          deletePostState: RequestState.error, deletePostMessage: l.message));
    }, (r) {
      return emit(PostState(
        deletePostState: RequestState.loaded,
      ));
    });
  }

  // Comment
  FutureOr<void> _getComment(
      GetCommentEvent event, Emitter<PostState> emit) async {
    // emit(PostState(postState: RequestState.loading));
    (await getCommentUsecase(event.postId)).fold((l) {
      return emit(PostState(
          commentState: RequestState.error, commentMessage: l.message));
    }, (r) {
      return emit(PostState(
        comment: r,
        commentState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _addComment(
      AddCommentEvent event, Emitter<PostState> emit) async {
    (await addCommentUsecase(event.comment)).fold((l) {
      return emit(PostState(
          addCommentState: RequestState.error, addCommentMessage: l.message));
    }, (r) {
      return emit(PostState(
        addCommentState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _updateComment(
      UpdateCommentEvent event, Emitter<PostState> emit) async {
    (await updateCommentUsecase(event.comment)).fold((l) {
      return emit(PostState(
          updateCommentState: RequestState.error,
          updateCommentMessage: l.message));
    }, (r) {
      return emit(PostState(
        updateCommentState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _deleteComment(
      DeleteCommentEvent event, Emitter<PostState> emit) async {
    (await deleteCommentUsecase(event.commentId)).fold((l) {
      // print("object");
      // print(l.message);
      return emit(PostState(
          deleteCommentState: RequestState.error,
          deleteCommentMessage: l.message));
    }, (r) {
      print("error");
      print(r);
      return emit(PostState(
        deleteCommentState: RequestState.loaded,
      ));
    });
  }

  // Like
  FutureOr<void> _getLike(GetLikeEvent event, Emitter<PostState> emit) async {
    (await getLikeUsecase(event.postId, event.userId)).fold((l) {
      return emit(
          PostState(likeState: RequestState.error, likeMessage: l.message));
    }, (r) {
      return emit(PostState(
        like: r,
        likeState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _addLike(AddLikeEvent event, Emitter<PostState> emit) async {
    int postId = event.like.postId;
    likeMap[postId] = likeMap[postId] == 0 ? 1 : 0;
    emit(PostState(
      addLikeState: RequestState.loaded,
    ));
    (await addLikeUsecase(event.like)).fold((l) {
      return emit(PostState(
          addLikeState: RequestState.error, addLikeMessage: l.message));
    }, (r) {
      return emit(PostState(
        addLikeState: RequestState.loaded,
      ));
    });
  }

  // FutureOr<void> _searchPostByFields(
  //     SearchPostByFieldsEvent event, Emitter<PostState> emit) async {
  //   (await searchPostByFieldsUsecase(event.postSearchByFeild)).fold((l) {
  //     return emit(PostState(
  //         searchPostState: RequestState.error,
  //         searchPostMessage: l.message));
  //   }, (r) {
  //     return emit(PostState(
  //       searchPost: r,
  //       searchPostState: RequestState.loaded,
  //     ));
  //   });
  // }

  // FutureOr<void> _orderingPostByFields(
  //     OrderingPostByFieldsEvent event, Emitter<PostState> emit) async {
  //   (await orderingPostByFieldsUsecase(event.postOrderingByFeild)).fold((l) {
  //     return emit(PostState(
  //         orderingPostState: RequestState.error,
  //         orderingPostMessage: l.message));
  //   }, (r) {
  //     return emit(PostState(
  //       orderingPostState: RequestState.loaded,
  //     ));
  //   });
  // }

}
