import 'package:comments_repository/comments_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:pinapp_challenge/app/app.dart';
import 'package:pinapp_challenge/bootstrap.dart';
import 'package:posts_repository/posts_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final postsRepository = PostsRepository.standard();
  final commentsRepository = CommentsRepository.standard();

  bootstrap(
    () => App(
      postsRepository: postsRepository,
      commentsRepository: commentsRepository,
    ),
  );
}
