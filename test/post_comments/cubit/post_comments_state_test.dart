import 'package:comments_repository/comments_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinapp_challenge/post_comments/cubit/post_comments_cubit.dart';
import 'package:posts_repository/posts_repository.dart';

class MockPostModel extends Mock implements PostModel {}

class MockCommentModel extends Mock implements CommentModel {}

void main() {
  late PostModel post;
  late CommentModel comment;

  setUpAll(() {
    registerFallbackValue(MockPostModel());
    registerFallbackValue(MockCommentModel());
  });

  setUp(() {
    post = MockPostModel();
    comment = MockCommentModel();

    when(() => post.id).thenReturn(1);
    when(() => post.userId).thenReturn(1);
    when(() => post.title).thenReturn('Test Title');
    when(() => post.body).thenReturn('Test Body');

    when(() => comment.id).thenReturn(1);
    when(() => comment.postId).thenReturn(1);
    when(() => comment.name).thenReturn('Test Name');
    when(() => comment.email).thenReturn('test@example.com');
    when(() => comment.body).thenReturn('Test Comment Body');
  });

  group('PostCommentsState', () {
    test('has correct initial values', () {
      final state = PostCommentsState(post: post);
      expect(state.status, PostCommentsStatus.initial);
      expect(state.comments, isEmpty);
      expect(state.post, equals(post));
    });

    test('copyWith returns new instance with updated fields', () {
      final state = PostCommentsState(post: post);
      final newState = state.copyWith(
        status: PostCommentsStatus.loading,
        comments: [comment],
      );
      expect(newState.status, PostCommentsStatus.loading);
      expect(newState.comments, equals([comment]));
      expect(newState.post, equals(post));
    });

    test('copyWith without parameters returns the same state', () {
      final state = PostCommentsState(post: post);
      final newState = state.copyWith();
      expect(newState, equals(state));
    });

    test('props returns all properties', () {
      final state = PostCommentsState(
        post: post,
        status: PostCommentsStatus.success,
        comments: [comment],
      );

      expect(
        state.props,
        equals([
          PostCommentsStatus.success,
          [comment],
          post,
        ]),
      );
    });
  });
}
