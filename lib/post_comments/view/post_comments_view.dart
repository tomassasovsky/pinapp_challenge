import 'package:comments_repository/comments_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp_challenge/l10n/l10n.dart';
import 'package:pinapp_challenge/post_comments/cubit/post_comments_cubit.dart';
import 'package:pinapp_challenge/post_list/widget/post_widget.dart';
import 'package:posts_repository/posts_repository.dart';

class PostCommentsPage extends StatelessWidget {
  const PostCommentsPage({
    required this.post,
    super.key,
  });

  factory PostCommentsPage.fromContext(BuildContext context) {
    return PostCommentsPage(
      post: ModalRoute.of(context)!.settings.arguments! as PostModel,
    );
  }

  static const route = '/posts/comments';

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostCommentsCubit(
        commentsRepository: context.read<CommentsRepository>(),
        post: post,
      )..getComments(),
      child: const PostCommentsView(),
    );
  }
}

class PostCommentsView extends StatelessWidget {
  const PostCommentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCommentsCubit, PostCommentsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: state.status != PostCommentsStatus.success ? AppBar() : null,
          body: switch (state.status) {
            PostCommentsStatus.loading =>
              const Center(child: CircularProgressIndicator()),
            PostCommentsStatus.success => _DataBody(state.post, state.comments),
            PostCommentsStatus.failure => const _RetryBody(),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}

class _DataBody extends StatelessWidget {
  const _DataBody(
    this.post,
    this.comments,
  );

  final PostModel post;
  final List<CommentModel> comments;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(title: Text(context.l10n.commentsForPost(post.id))),
        SliverToBoxAdapter(child: PostWidget(post)),
        SliverList.builder(
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final comment = comments[index];
            return _CommentWidget(comment);
          },
        ),
      ],
    );
  }
}

class _CommentWidget extends StatelessWidget {
  const _CommentWidget(this.comment);

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            comment.name ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            comment.body ?? '',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            context.l10n.postedBy(comment.email ?? ''),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _RetryBody extends StatelessWidget {
  const _RetryBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(context.l10n.failedToLoadComments),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: context.read<PostCommentsCubit>().getComments,
            child: Text(context.l10n.retry),
          ),
        ],
      ),
    );
  }
}
