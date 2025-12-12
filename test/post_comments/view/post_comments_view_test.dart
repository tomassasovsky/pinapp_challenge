import 'package:bloc_test/bloc_test.dart';
import 'package:comments_repository/comments_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinapp_challenge/l10n/arb/app_localizations.dart';
import 'package:pinapp_challenge/post_comments/cubit/post_comments_cubit.dart';
import 'package:pinapp_challenge/post_comments/view/post_comments_view.dart';
import 'package:pinapp_challenge/post_list/widget/post_widget.dart';
import 'package:pinapp_challenge/retry_widget.dart';
import 'package:posts_repository/posts_repository.dart';

class MockPostModel extends Mock implements PostModel {}

class MockCommentModel extends Mock implements CommentModel {}

// Fake L10n implementation
class FakeL10nImpl implements AppLocalizations {
  @override
  String get failedToLoadComments => 'Failed to load comments';

  @override
  String commentsForPost(Object postId) => 'Comments for Post $postId';

  @override
  String postedBy(Object email) => 'Posted by $email';

  @override
  String get failedToLoadPosts => 'Failed to load posts';

  @override
  String get localeName => 'en';

  @override
  String get posts => 'Posts';

  @override
  String get retry => 'Retry';
}

// Fake L10n delegate
class FakeL10nDelegate extends LocalizationsDelegate<AppLocalizations> {
  const FakeL10nDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<AppLocalizations> load(Locale locale) async => FakeL10nImpl();

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

class MockPostCommentsCubit extends MockCubit<PostCommentsState>
    implements PostCommentsCubit {}

void main() {
  setUpAll(() {
    registerFallbackValue(MockPostModel());
    registerFallbackValue(MockCommentModel());
    registerFallbackValue(PostCommentsState(post: MockPostModel()));
  });

  late PostCommentsCubit cubit;
  late PostModel post;
  late CommentModel comment;

  setUp(() {
    cubit = MockPostCommentsCubit();
    post = MockPostModel();
    comment = MockCommentModel();

    when(() => post.id).thenReturn(1);
    when(() => post.body).thenReturn('Test post body');
    when(() => post.title).thenReturn('Test Post');
    when(() => post.userId).thenReturn(1);

    when(() => comment.id).thenReturn(1);
    when(() => comment.name).thenReturn('Test Comment');
    when(() => comment.body).thenReturn('Test comment body');
    when(() => comment.email).thenReturn('test@example.com');
  });

  Widget buildTestableWidget({required Widget child}) {
    return MaterialApp(
      localizationsDelegates: const [FakeL10nDelegate()],
      supportedLocales: const [Locale('en')],
      home: Scaffold(
        body: BlocProvider<PostCommentsCubit>.value(
          value: cubit,
          child: child,
        ),
      ),
    );
  }

  group('PostCommentsView', () {
    testWidgets('displays loading indicator when state is loading',
        (tester) async {
      when(() => cubit.state).thenReturn(
        PostCommentsState(
          post: post,
          status: PostCommentsStatus.loading,
        ),
      );

      await tester
          .pumpWidget(buildTestableWidget(child: const PostCommentsView()));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('displays RetryWidget when state is failure', (tester) async {
      when(() => cubit.state).thenReturn(
        PostCommentsState(
          post: post,
          status: PostCommentsStatus.failure,
        ),
      );

      await tester
          .pumpWidget(buildTestableWidget(child: const PostCommentsView()));
      await tester.pump();

      expect(find.byType(RetryWidget), findsOneWidget);
      expect(find.text('Failed to load comments'), findsOneWidget);
    });

    testWidgets('displays comments view when state is success', (tester) async {
      when(() => cubit.state).thenReturn(
        PostCommentsState(
          post: post,
          status: PostCommentsStatus.success,
          comments: [comment],
        ),
      );

      await tester
          .pumpWidget(buildTestableWidget(child: const PostCommentsView()));
      await tester.pumpAndSettle();

      // Since state is success, no AppBar from the Scaffold,
      // but _DataBody creates a SliverAppBar with a title.
      expect(find.byType(SliverAppBar), findsOneWidget);
      expect(find.text('Comments for Post 1'), findsOneWidget);
      // Ensure PostWidget is rendered.
      expect(find.byType(PostWidget), findsOneWidget);
      // Verify the comment details are present.
      expect(find.text('Test comment body'), findsOneWidget);
      expect(find.text('Test Comment'), findsOneWidget);
      expect(find.text('Posted by test@example.com'), findsOneWidget);
      // RefreshIndicator should be present.
      expect(find.byType(RefreshIndicator), findsOneWidget);
    });
  });
}
