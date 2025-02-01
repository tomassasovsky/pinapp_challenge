import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinapp_challenge/post_list/cubit/post_list_cubit.dart';
import 'package:posts_repository/posts_repository.dart';

class MockPostModel extends Mock implements PostModel {}

void main() {
  late PostModel post;

  setUpAll(() {
    registerFallbackValue(MockPostModel());
  });

  setUp(() {
    post = MockPostModel();

    when(() => post.id).thenReturn(1);
    when(() => post.userId).thenReturn(1);
    when(() => post.title).thenReturn('Test Title');
    when(() => post.body).thenReturn('Test Body');
  });

  group('PostListState', () {
    test('has correct initial values', () {
      const state = PostListState();
      expect(state.status, PostListStatus.initial);
      expect(state.posts, isEmpty);
    });

    test('copyWith returns new instance with updated fields', () {
      const state = PostListState();
      final newState = state.copyWith(
        status: PostListStatus.loading,
        posts: [post],
      );
      expect(newState.status, PostListStatus.loading);
      expect(newState.posts, equals([post]));
    });

    test('copyWith without parameters returns the same state', () {
      const state = PostListState();
      final newState = state.copyWith();
      expect(newState, equals(state));
    });

    test('props returns all properties', () {
      final state = PostListState(
        posts: [post],
        status: PostListStatus.success,
      );

      expect(
        state.props,
        equals([
          PostListStatus.success,
          [post],
        ]),
      );
    });
  });
}
