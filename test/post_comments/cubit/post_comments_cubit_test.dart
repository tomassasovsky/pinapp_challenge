import 'package:bloc_test/bloc_test.dart';
import 'package:comments_repository/comments_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinapp_challenge/post_comments/cubit/post_comments_cubit.dart';
import 'package:posts_repository/posts_repository.dart';

class MockCommentsRepository extends Mock implements CommentsRepository {}

class MockPostModel extends Mock implements PostModel {}

class MockCommentModel extends Mock implements CommentModel {}

void main() {
  late MockCommentsRepository commentsRepository;
  late PostModel post;
  late CommentModel comment;

  setUp(() {
    post = MockPostModel();
    comment = MockCommentModel();

    when(() => post.id).thenReturn(1);
    when(() => post.userId).thenReturn(1);
    when(() => post.title).thenReturn('title');
    when(() => post.body).thenReturn('body');

    when(() => comment.id).thenReturn(1);
    when(() => comment.postId).thenReturn(1);
    when(() => comment.name).thenReturn('name');
    when(() => comment.email).thenReturn('email');
    when(() => comment.body).thenReturn('body');

    commentsRepository = MockCommentsRepository();

    when(() => commentsRepository.getComments(postId: any(named: 'postId')))
        .thenAnswer((_) async => [comment]);
  });

  group('PostCommentsCubit', () {
    test('initial state has the provided post', () {
      final cubit =
          PostCommentsCubit(post: post, commentsRepository: commentsRepository);
      expect(cubit.state.post, equals(post));
    });

    blocTest<PostCommentsCubit, PostCommentsState>(
      'emits [loading, success] when getComments succeeds',
      build: () {
        return PostCommentsCubit(
          post: post,
          commentsRepository: commentsRepository,
        );
      },
      act: (cubit) => cubit.getComments(),
      expect: () {
        final initial = PostCommentsState(post: post);
        return [
          initial.copyWith(status: PostCommentsStatus.loading),
          initial.copyWith(
            status: PostCommentsStatus.success,
            comments: [comment],
          ),
        ];
      },
    );

    blocTest<PostCommentsCubit, PostCommentsState>(
      'emits [loading, failure] when getComments throws an exception',
      build: () {
        when(() => commentsRepository.getComments(postId: post.id))
            .thenThrow(Exception('error'));
        return PostCommentsCubit(
          post: post,
          commentsRepository: commentsRepository,
        );
      },
      act: (cubit) => cubit.getComments(),
      expect: () {
        final initial = PostCommentsState(post: post);
        return [
          initial.copyWith(status: PostCommentsStatus.loading),
          initial.copyWith(status: PostCommentsStatus.failure),
        ];
      },
    );
  });
}
