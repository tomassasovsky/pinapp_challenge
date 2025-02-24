import 'package:bloc_test/bloc_test.dart';
import 'package:comments_repository/comments_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinapp_challenge/l10n/l10n.dart';
import 'package:pinapp_challenge/post_comments/view/post_comments_view.dart';
import 'package:pinapp_challenge/post_list/cubit/post_list_cubit.dart';
import 'package:pinapp_challenge/post_list/view/post_list_view.dart';
import 'package:pinapp_challenge/post_list/widget/post_widget.dart';
import 'package:pinapp_challenge/retry_widget.dart';
import 'package:posts_repository/posts_repository.dart';

class MockPostModel extends Mock implements PostModel {}

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

class MockPostListCubit extends MockCubit<PostListState>
    implements PostListCubit {}

class MockCommentsRepository extends Mock implements CommentsRepository {}

class MockComment extends Mock implements CommentModel {}

void main() {
  setUpAll(() {
    registerFallbackValue(MockPostModel());
    registerFallbackValue(MockCommentsRepository());
    registerFallbackValue(const PostListState());
  });

  late MockPostListCubit cubit;
  late CommentsRepository commentsRepository;
  late PostModel post;
  late CommentModel comment;

  setUp(() {
    cubit = MockPostListCubit();
    post = MockPostModel();
    commentsRepository = MockCommentsRepository();
    comment = MockComment();

    when(() => post.id).thenReturn(1);
    when(() => post.body).thenReturn('Test post body');
    when(() => post.title).thenReturn('Test Post');
    when(() => post.userId).thenReturn(1);

    when(() => comment.id).thenReturn(1);
    when(() => comment.body).thenReturn('Test comment body');
    when(() => comment.email).thenReturn('Test comment email');
    when(() => comment.name).thenReturn('Test comment name');
    when(() => comment.postId).thenReturn(1);

    when(() => commentsRepository.getComments(postId: any(named: 'postId')))
        .thenAnswer((_) async => [comment]);
  });

  Widget buildTestableWidget({required Widget child}) {
    return RepositoryProvider.value(
      value: commentsRepository,
      child: MaterialApp(
        localizationsDelegates: const [FakeL10nDelegate()],
        supportedLocales: const [Locale('en')],
        home: Scaffold(
          body: BlocProvider<PostListCubit>.value(
            value: cubit,
            child: child,
          ),
        ),
        routes: const {
          PostCommentsPage.route: PostCommentsPage.fromContext,
        },
      ),
    );
  }

  group('PostListView', () {
    testWidgets('displays loading indicator when state is loading',
        (tester) async {
      when(() => cubit.state).thenReturn(
        PostListState(
          posts: [post],
          status: PostListStatus.loading,
        ),
      );

      await tester.pumpWidget(buildTestableWidget(child: const PostListView()));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('displays RetryWidget when state is failure', (tester) async {
      when(() => cubit.state).thenReturn(
        PostListState(
          posts: [post],
          status: PostListStatus.failure,
        ),
      );

      await tester.pumpWidget(buildTestableWidget(child: const PostListView()));
      await tester.pump();

      expect(find.byType(RetryWidget), findsOneWidget);
      expect(find.text('Failed to load posts'), findsOneWidget);
    });

    testWidgets('displays posts view when state is success', (tester) async {
      when(() => cubit.state).thenReturn(
        PostListState(
          posts: [post],
          status: PostListStatus.success,
        ),
      );

      await tester.pumpWidget(buildTestableWidget(child: const PostListView()));
      await tester.pumpAndSettle();

      // Since state is success, no AppBar from the Scaffold,
      // but _DataBody creates a SliverAppBar with a title.
      expect(find.byType(SliverAppBar), findsOneWidget);
      expect(find.text('Posts'), findsOneWidget);
      // Ensure PostWidget is rendered.
      expect(find.byType(PostWidget), findsOneWidget);
      // Verify the post details are present.
      expect(find.text('Test post body'), findsOneWidget);
      expect(find.text('Test Post'), findsOneWidget);
      // RefreshIndicator should be present.
      expect(find.byType(RefreshIndicator), findsOneWidget);
    });

    testWidgets('redirects to comments view when post is tapped',
        (tester) async {
      when(() => cubit.state).thenReturn(
        PostListState(
          posts: [post],
          status: PostListStatus.success,
        ),
      );

      await tester.pumpWidget(buildTestableWidget(child: const PostListView()));
      await tester.pumpAndSettle();

      // Since state is success, no AppBar from the Scaffold,
      // but _DataBody creates a SliverAppBar with a title.
      expect(find.byType(SliverAppBar), findsOneWidget);
      expect(find.text('Posts'), findsOneWidget);
      // Ensure PostWidget is rendered.
      expect(find.byType(PostWidget), findsOneWidget);
      // Verify the post details are present.
      expect(find.text('Test post body'), findsOneWidget);
      expect(find.text('Test Post'), findsOneWidget);
      // RefreshIndicator should be present.
      expect(find.byType(RefreshIndicator), findsOneWidget);

      // Tap on the post to navigate to the comments view.
      await tester.tap(find.byType(PostWidget));

      await tester.pumpAndSettle();

      // Verify the navigation to the comments view.
      expect(find.byType(PostCommentsPage), findsOneWidget);
    });
  });
}
