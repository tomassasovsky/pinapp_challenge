part of 'post_list_cubit.dart';

enum PostListStatus {
  initial,
  loading,
  success,
  failure,
}

class PostListState extends Equatable {
  const PostListState({
    this.status = PostListStatus.initial,
    this.posts = const <PostModel>[],
  });

  final PostListStatus status;
  final List<PostModel> posts;

  PostListState copyWith({
    PostListStatus? status,
    List<PostModel>? posts,
  }) {
    return PostListState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object> get props => [status, posts];
}
