import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp_challenge/l10n/l10n.dart';
import 'package:pinapp_challenge/post_comments/view/post_comments_view.dart';
import 'package:pinapp_challenge/post_list/cubit/post_list_cubit.dart';
import 'package:pinapp_challenge/post_list/widget/post_widget.dart';
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
            PostListStatus.failure => const _RetryBody(),
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
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(context.l10n.posts),
          floating: true,
          snap: true,
        ),
        SliverList.builder(
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
          Text(context.l10n.failedToLoadPosts),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: context.read<PostListCubit>().getPosts,
            child: Text(context.l10n.retry),
          ),
        ],
      ),
    );
  }
}
