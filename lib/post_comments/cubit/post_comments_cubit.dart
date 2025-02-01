import 'package:bloc/bloc.dart';
import 'package:comments_repository/comments_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_repository/posts_repository.dart';

part 'post_comments_state.dart';

class PostCommentsCubit extends Cubit<PostCommentsState> {
  PostCommentsCubit({
    required PostModel post,
    required CommentsRepository commentsRepository,
  })  : _commentsRepository = commentsRepository,
        super(PostCommentsState(post: post));

  Future<void> getComments() async {
    emit(state.copyWith(status: PostCommentsStatus.loading));

    try {
      final comments =
          await _commentsRepository.getComments(postId: state.post.id);

      emit(
        state.copyWith(
          status: PostCommentsStatus.success,
          comments: comments,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: PostCommentsStatus.failure));
    }
  }

  final CommentsRepository _commentsRepository;
}
