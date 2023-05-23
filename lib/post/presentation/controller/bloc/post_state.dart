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

    // this.searchPost = const [],
    // this.searchPostState = RequestState.loading,
    // this.searchPostMessage = '',
    // this.orderingPost = const [],
    // this.orderingPostState = RequestState.loading,
    // this.orderingPostMessage = '',
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

      // searchHotels: searchHotels ?? this.searchHotels,
      // searchHotelState: searchHotelState ?? this.searchHotelState,
      // searchHotelsMessage: searchHotelsMessage ?? this.searchHotelsMessage,

      // orderingPost: orderingPost ?? this.orderingPost,
      // orderingPostState: orderingPostState ?? this.orderingPostState,
      // orderingPostMessage: orderingPostMessage ?? this.orderingPostMessage,
    );
  }
}