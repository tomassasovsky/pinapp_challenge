import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_repository/posts_repository.dart';

part 'post_list_state.dart';

class PostListCubit extends Cubit<PostListState> {
  PostListCubit({
    required PostsRepository postsRepository,
  })  : _postsRepository = postsRepository,
        super(const PostListState());

  final PostsRepository _postsRepository;

  Future<void> getPosts() async {
    emit(state.copyWith(status: PostListStatus.loading));
    try {
      final posts = await _postsRepository
          .getPosts()
          .timeout(const Duration(seconds: 10));

      emit(state.copyWith(status: PostListStatus.success, posts: posts));
    } on Exception {
      emit(state.copyWith(status: PostListStatus.failure));
    }
  }
}
