part of 'post_comments_cubit.dart';

enum PostCommentsStatus {
  initial,
  loading,
  success,
  failure,
}

class PostCommentsState extends Equatable {
  const PostCommentsState({
    required this.post,
    this.status = PostCommentsStatus.initial,
    this.comments = const <CommentModel>[],
  });

  final PostCommentsStatus status;
  final List<CommentModel> comments;
  final PostModel post;

  PostCommentsState copyWith({
    PostCommentsStatus? status,
    List<CommentModel>? comments,
    PostModel? post,
  }) {
    return PostCommentsState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
      post: post ?? this.post,
    );
  }

  @override
  List<Object> get props => [status, comments, post];
}
