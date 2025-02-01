import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp_challenge/l10n/l10n.dart';
import 'package:pinapp_challenge/post_comments/view/post_comments_view.dart';
import 'package:pinapp_challenge/post_list/cubit/post_list_cubit.dart';
import 'package:pinapp_challenge/post_list/widget/post_widget.dart';
import 'package:pinapp_challenge/retry_widget.dart';
import 'package:posts_repository/posts_repository.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  static const route = '/posts';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostListCubit(
        postsRepository: context.read<PostsRepository>(),
      )..getPosts(),
      child: const PostListView(),
    );
  }
}

class PostListView extends StatelessWidget {
  const PostListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostListCubit, PostListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: state.status != PostListStatus.success
              ? AppBar(title: Text(context.l10n.posts))
              : null,
          body: switch (state.status) {
            PostListStatus.success => _BodyData(state.posts),
            PostListStatus.failure => RetryWidget(
                errorMessage: context.l10n.failedToLoadPosts,
                onRetry: context.read<PostListCubit>().getPosts,
              ),
            _ => const Center(child: CircularProgressIndicator()),
          },
        );
      },
    );
  }
}

class _BodyData extends StatelessWidget {
  const _BodyData(this.posts);

  final List<PostModel> posts;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: context.read<PostListCubit>().getPosts,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(context.l10n.posts),
            floating: true,
            snap: true,
          ),
          SliverList.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostWidget(
                post,
                onTap: () => Navigator.of(context).pushNamed(
                  PostCommentsPage.route,
                  arguments: post,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
