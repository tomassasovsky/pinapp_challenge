import 'package:pigeon/pigeon.dart';

/// Data class representing a comment.
class CommentModel {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;
}

/// Host API for fetching comments from the native side.
///
/// This asynchronous method returns a list of [CommentModel] objects after
/// performing a REST API call natively.
@HostApi()
abstract class CommentApi {
  /// Sets the base URL configuration.
  /// The native side should store these values and use them to construct the
  /// URL.
  void setBaseUrl(String scheme, String authority, int port);

  /// Returns a list of [CommentModel] instances for the given postId.
  List<CommentModel> getComments(int postId);
}
