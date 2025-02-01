import 'package:comments_repository/src/generated/generated.dart';

/// A repository for fetching comments using the native integration.
///
/// This repository has two constructors: one for self-hosted
/// (custom API endpoint)
/// and one for standard (production API endpoint). (Note: for the native API to
/// honor these settings, you’d need to propagate them to the native side.)
class CommentsRepository {
  /// Creates a self-hosted instance of [CommentsRepository].
  ///
  /// The [scheme], [authority], and [port] must be provided.
  CommentsRepository.selfHosted({
    required this.scheme,
    required this.authority,
    required this.port,
  }) : _commentApi = CommentApi()..setBaseUrl(scheme, authority, port);

  /// Creates a standard instance of [CommentsRepository] using production API
  /// settings.
  ///
  /// The standard settings are:
  /// - scheme: `https`
  /// - authority: `jsonplaceholder.typicode.com`
  /// - port: `443`
  CommentsRepository.standard()
      : scheme = 'https',
        authority = 'jsonplaceholder.typicode.com',
        port = 443,
        _commentApi = CommentApi()
          ..setBaseUrl('https', 'jsonplaceholder.typicode.com', 443);

  /// The scheme of the API (for example, `http` or `https`).
  final String scheme;

  /// The authority (host) of the API.
  final String authority;

  /// The port number of the API.
  final int port;

  final CommentApi _commentApi;

  /// Fetches a list of comments for the given [postId].
  ///
  /// The native implementation of [CommentApi.getComments] will perform a REST
  /// API call,
  /// parse the JSON response, and return a list of [CommentModel] objects.
  ///
  /// Returns a [Future] that completes with a list of [CommentModel] if
  /// successful,
  /// or throws an exception if the network call or parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final repository = CommentsRepository();
  /// final comments = await repository.getComments(postId: 1);
  /// print('Received ${comments.length} comments for post 1');
  /// ```
  Future<List<CommentModel>> getComments({required int postId}) async {
    try {
      final comments = await _commentApi.getComments(postId);
      return comments;
    } catch (error) {
      throw Exception('Failed to fetch comments: $error');
    }
  }
}
