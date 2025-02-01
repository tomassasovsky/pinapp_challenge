import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinapp_challenge/post_list/cubit/post_list_cubit.dart';
import 'package:posts_repository/posts_repository.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

class MockPostModel extends Mock implements PostModel {}

void main() {
  late PostsRepository postsRepository;
  late PostModel post;

  setUp(() {
    post = MockPostModel();

    when(() => post.id).thenReturn(1);
    when(() => post.userId).thenReturn(1);
    when(() => post.title).thenReturn('title');
    when(() => post.body).thenReturn('body');

    postsRepository = MockPostsRepository();

    when(() => postsRepository.getPosts()).thenAnswer((_) async => [post]);
  });

  group('PostListCubit', () {
    test('initial state is correct', () {
      final cubit = PostListCubit(postsRepository: postsRepository);
      expect(cubit.state, equals(const PostListState()));
    });

    blocTest<PostListCubit, PostListState>(
      'emits [loading, success] when getPosts succeeds',
      build: () {
        return PostListCubit(postsRepository: postsRepository);
      },
      act: (cubit) => cubit.getPosts(),
      expect: () {
        const initial = PostListState();
        return [
          initial.copyWith(status: PostListStatus.loading),
          initial.copyWith(
            status: PostListStatus.success,
            posts: [post],
          ),
        ];
      },
    );

    blocTest<PostListCubit, PostListState>(
      'emits [loading, failure] when getPosts throws an exception',
      build: () {
        when(() => postsRepository.getPosts()).thenThrow(Exception('error'));
        return PostListCubit(postsRepository: postsRepository);
      },
      act: (cubit) => cubit.getPosts(),
      expect: () {
        const initial = PostListState();
        return [
          initial.copyWith(status: PostListStatus.loading),
          initial.copyWith(status: PostListStatus.failure),
        ];
      },
    );
  });
}
