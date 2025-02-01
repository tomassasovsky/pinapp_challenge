import 'dart:async';

import 'package:comments_repository/comments_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinapp_challenge/app/view/app.dart';
import 'package:pinapp_challenge/l10n/l10n.dart';
import 'package:pinapp_challenge/post_comments/view/post_comments_view.dart';
import 'package:pinapp_challenge/post_list/view/post_list_view.dart';
import 'package:posts_repository/posts_repository.dart';

class FakePostsRepository extends Mock implements PostsRepository {}

class FakeCommentsRepository extends Mock implements CommentsRepository {}

class MockPostModel extends Mock implements PostModel {}

class MockCommentModel extends Mock implements CommentModel {}

void main() {
  group('App', () {
    late PostsRepository postsRepository;
    late CommentsRepository commentsRepository;
    late PostModel postModel;
    late CommentModel commentModel;

    setUp(() {
      postsRepository = FakePostsRepository();
      commentsRepository = FakeCommentsRepository();
      postModel = MockPostModel();
      commentModel = MockCommentModel();

      when(() => postModel.id).thenReturn(1);
      when(() => postModel.body).thenReturn('body');
      when(() => postModel.title).thenReturn('title');
      when(() => postModel.userId).thenReturn(1);
      when(() => commentModel.postId).thenReturn(1);
      when(() => commentModel.name).thenReturn('name');
      when(() => commentModel.body).thenReturn('body');
      when(() => commentModel.email).thenReturn('email');
      when(() => commentModel.id).thenReturn(1);

      when(() => postsRepository.getPosts())
          .thenAnswer((_) async => [postModel]);

      when(() => commentsRepository.getComments(postId: any(named: 'postId')))
          .thenAnswer((_) async => [commentModel]);
    });

    Widget getTestableApp() {
      return App(
        postsRepository: postsRepository,
        commentsRepository: commentsRepository,
      );
    }

    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        App(
          postsRepository: postsRepository,
          commentsRepository: commentsRepository,
        ),
      );

      expect(find.byType(AppView), findsOneWidget);
    });

    testWidgets(
        'provides PostsRepository and CommentsRepository to the widget tree',
        (tester) async {
      await tester.pumpWidget(
        App(
          postsRepository: postsRepository,
          commentsRepository: commentsRepository,
        ),
      );

      final context = tester.element(find.byType(AppView));

      expect(
        RepositoryProvider.of<PostsRepository>(context),
        equals(postsRepository),
      );
      expect(
        RepositoryProvider.of<CommentsRepository>(context),
        equals(commentsRepository),
      );
    });

    testWidgets('builds a MaterialApp with the correct initialRoute and routes',
        (tester) async {
      await tester.pumpWidget(getTestableApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

      expect(materialApp.initialRoute, PostListPage.route);

      expect(materialApp.routes, contains(PostListPage.route));
      expect(materialApp.routes, contains(PostCommentsPage.route));
    });

    testWidgets('navigates to PostListPage as the initial route',
        (tester) async {
      await tester.pumpWidget(getTestableApp());
      await tester.pumpAndSettle();

      expect(find.byType(PostListPage), findsOneWidget);
    });

    testWidgets('navigates to PostCommentsPage when the route is pushed',
        (tester) async {
      await tester.pumpWidget(getTestableApp());
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(PostListPage));

      final navigator = Navigator.of(context);
      unawaited(
        navigator.pushNamed(PostCommentsPage.route, arguments: postModel),
      );

      await tester.pumpAndSettle();

      expect(find.byType(PostCommentsPage), findsOneWidget);
    });

    testWidgets('has correct localizationsDelegates and supportedLocales',
        (tester) async {
      await tester.pumpWidget(getTestableApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

      expect(
        materialApp.localizationsDelegates,
        AppLocalizations.localizationsDelegates,
      );
      expect(materialApp.supportedLocales, AppLocalizations.supportedLocales);
    });

    testWidgets('uses Material 3 in the theme', (tester) async {
      await tester.pumpWidget(getTestableApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.useMaterial3, isTrue);
    });
  });
}
