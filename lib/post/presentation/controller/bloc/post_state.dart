part of 'post_bloc.dart';

class PostState {
  final List<Post> post;
  final RequestState postState;
  final String postMessage;

  final Post? postById;
  final RequestState postStateById;
  final String postMessageById;

  final RequestState addPostState;
  final String addPostMessage;

  final RequestState updatePostState;
  final String updatePostMessage;

  final RequestState deletePostState;
  final String deletePostMessage;

  // Comment
  final List<Comment> comment;
  final RequestState commentState;
  final String commentMessage;

  final RequestState addCommentState;
  final String addCommentMessage;

  final RequestState updateCommentState;
  final String updateCommentMessage;

  final RequestState deleteCommentState;
  final String deleteCommentMessage;

  // Like
  final String like;
  final RequestState likeState;
  final String likeMessage;

  final RequestState addLikeState;
  final String addLikeMessage;

  // final List<Post> searchPost;
  // final RequestState searchPostState;
  // final String searchPostMessage;

  // final List<Post> searchHotelRate;
  // final RequestState searchHotelRateState;
  // final String searchHotelRateMessage;

  // final List<Post> orderingPost;
  // final RequestState orderingPostState;
  // final String orderingPostMessage;

  PostState({
    // this.searchPost = const [],
    // this.searchPostState = RequestState.loading,
    // this.searchPostMessage = '',
    // this.orderingPost = const [],
    // this.orderingPostState = RequestState.loading,
    // this.orderingPostMessage = '',
    this.post = const [],
    this.postState = RequestState.loading,
    this.postMessage = '',
    this.postById,
    this.postStateById = RequestState.loading,
    this.postMessageById = '',
    this.addPostState = RequestState.loading,
    this.addPostMessage = '',
    this.updatePostState = RequestState.loading,
    this.updatePostMessage = '',
    this.deletePostState = RequestState.loading,
    this.deletePostMessage = '',
    // Comment
    this.comment = const [],
    this.commentState = RequestState.loading,
    this.commentMessage = '',
    this.addCommentState = RequestState.loading,
    this.addCommentMessage = '',
    this.updateCommentState = RequestState.loading,
    this.updateCommentMessage = '',
    this.deleteCommentState = RequestState.loading,
    this.deleteCommentMessage = '',
    // Like
    this.like = '',
    this.likeState = RequestState.loading,
    this.likeMessage = '',
    this.addLikeState = RequestState.loading,
    this.addLikeMessage = '',
  });

  PostState copyWith({
    List<Post>? post,
    RequestState? postState,
    String? postMessage,
    Post? postById,
    RequestState? postStateById,
    String? postMessageById,
    RequestState? addPostState,
    String? addPostMessage,
    RequestState? updatePostState,
    String? updatePostMessage,
    RequestState? deletePostState,
    String? deletePostMessage,

    // Comment
    List<Comment>? comment,
    RequestState? commentState,
    String? commentMessage,
    RequestState? addCommentState,
    String? addCommentMessage,
    RequestState? updateCommentState,
    String? updateCommentMessage,
    RequestState? deleteCommentState,
    String? deleteCommentMessage,

    // Like
    String? like,
    RequestState? likeState,
    String? likeMessage,
    RequestState? addLikeState,
    String? addLikeMessage,

    // List<Post>? searchPost,
    // RequestState? searchHotelState,
    // String? searchHotelsMessage,

    // List<Post>? orderingPost,
    // RequestState? orderingPostState,
    // String? orderingPostMessage,
  }) {
    return PostState(
      post: post ?? this.post,
      postState: postState ?? this.postState,
      postMessage: postMessage ?? this.postMessage,

      postById: postById ?? this.postById,
      postStateById: postStateById ?? this.postStateById,
      postMessageById: postMessageById ?? this.postMessageById,

      addPostState: addPostState ?? this.addPostState,
      addPostMessage: addPostMessage ?? this.addPostMessage,

      updatePostState: updatePostState ?? this.updatePostState,
      updatePostMessage: updatePostMessage ?? this.updatePostMessage,

      deletePostState: deletePostState ?? this.deletePostState,
      deletePostMessage: deletePostMessage ?? this.deletePostMessage,

      // Comment
      comment: comment ?? this.comment,
      commentState: commentState ?? this.commentState,
      commentMessage: commentMessage ?? this.commentMessage,

      addCommentState: addCommentState ?? this.addCommentState,
      addCommentMessage: addCommentMessage ?? this.addCommentMessage,

      updateCommentState: updateCommentState ?? this.updateCommentState,
      updateCommentMessage: updateCommentMessage ?? this.updateCommentMessage,

      deleteCommentState: deleteCommentState ?? this.deleteCommentState,
      deleteCommentMessage: deleteCommentMessage ?? this.deleteCommentMessage,

      // Like
      like: like ?? this.like,
      likeState: likeState ?? this.likeState,
      likeMessage: likeMessage ?? this.likeMessage,
      addLikeState: addLikeState ?? this.addLikeState,
      addLikeMessage: addLikeMessage ?? this.addLikeMessage,

      // searchHotels: searchHotels ?? this.searchHotels,
      // searchHotelState: searchHotelState ?? this.searchHotelState,
      // searchHotelsMessage: searchHotelsMessage ?? this.searchHotelsMessage,

      // orderingPost: orderingPost ?? this.orderingPost,
      // orderingPostState: orderingPostState ?? this.orderingPostState,
      // orderingPostMessage: orderingPostMessage ?? this.orderingPostMessage,
    );
  }
}
