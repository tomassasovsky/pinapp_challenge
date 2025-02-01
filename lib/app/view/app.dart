import 'package:comments_repository/comments_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp_challenge/l10n/l10n.dart';
import 'package:pinapp_challenge/post_comments/view/post_comments_view.dart';
import 'package:pinapp_challenge/post_list/view/post_list_view.dart';
import 'package:posts_repository/posts_repository.dart';

/// {@template app}
/// A [MaterialApp] which sets the theme and localizations.
///
/// This widget also wraps the [AppView] in a [MultiRepositoryProvider] in order
/// to provide the [PostsRepository] and [CommentsRepository] to the rest of the
/// application.
/// {@endtemplate}
class App extends StatelessWidget {
  const App({
    required PostsRepository postsRepository,
    required CommentsRepository commentsRepository,
    super.key,
  })  : _postsRepository = postsRepository,
        _counterRepository = commentsRepository;

  final PostsRepository _postsRepository;
  final CommentsRepository _counterRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _postsRepository),
        RepositoryProvider.value(value: _counterRepository),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: PostListPage.route,
      routes: {
        PostListPage.route: (context) => const PostListPage(),
        PostCommentsPage.route: PostCommentsPage.fromContext,
      },
    );
  }
}
