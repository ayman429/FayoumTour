import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecase/add_post_usecase.dart';
import '../../../domain/usecase/delete_post_usecase.dart';
import '../../../domain/usecase/get_post_by_id_usecase.dart';
import '../../../domain/usecase/get_post_usecase.dart';
import '../../../domain/usecase/update_post_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostUsecase getPostUsecase;
  final GetPostByIdUsecase getPostByIdUsecase;

  final AddPostUsecase addPostUsecase;
  final UpdatePostUsecase updatePostUsecase;
  final DeletePostUsecase deletePostUsecase;

  // final OrderingPostByFieldsUsecase orderingPostByFieldsUsecase;
  // final SearchByFieldsPostUsecase searchPostByFieldsUsecase;
  PostBloc(
    this.getPostUsecase,
    this.getPostByIdUsecase,
    this.addPostUsecase,
    this.updatePostUsecase,
    this.deletePostUsecase,

    // this.orderingPostByFieldsUsecase,
    // this.searchPostByFieldsUsecase,
    // this.searchPostByRateUsecase,
  ) : super(PostState()) {
    on<GetPostEvent>(_getPost);
    on<GetPostByIdEvent>(_getPostById);
    on<AddPostEvent>(_addPost);
    on<UpdatePostEvent>(_updatePost);
    on<DeletePostEvent>(_deletePost);

    // on<OrderingPostByFieldsEvent>(_orderingPostByFields);
    // on<SearchPostByFieldsEvent>(_searchPostByFields);
  }

  FutureOr<void> _getPost(GetPostEvent event, Emitter<PostState> emit) async {
    (await getPostUsecase(const NoParameters())).fold((l) {
      return emit(
          PostState(postState: RequestState.error, postMessage: l.message));
    }, (r) {
      return emit(PostState(
        post: r,
        postState: RequestState.loaded,
      ));
    });
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
    (await addPostUsecase(event.post)).fold((l) {
      return emit(PostState(
          addPostState: RequestState.error, addPostMessage: l.message));
    }, (r) {
      return emit(PostState(
        addPostState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _updatePost(
      UpdatePostEvent event, Emitter<PostState> emit) async {
    (await updatePostUsecase(event.post)).fold((l) {
      return emit(PostState(
          updatePostState: RequestState.error, updatePostMessage: l.message));
    }, (r) {
      return emit(PostState(
        updatePostState: RequestState.loaded,
      ));
    });
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
