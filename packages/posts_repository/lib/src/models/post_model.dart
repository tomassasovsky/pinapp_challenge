/// A model representing a post retrieved from a JSON API.
///
/// This model holds details about the post such as the user ID,
/// post ID, title, and body of the post.
class PostModel {
  /// Creates a constant instance of [PostModel].
  ///
  /// All fields are required.
  const PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  /// Constructs a [PostModel] instance from a JSON map.
  ///
  /// The provided JSON map must contain the following keys:
  /// - `userId`: The ID of the user who created the post, as an [int].
  /// - `id`: The unique identifier of the post, as an [int].
  /// - `title`: The title of the post, as a [String].
  /// - `body`: The content body of the post, as a [String].
  ///
  /// Example:
  /// ```dart
  /// final json = {
  ///   'userId': 1,
  ///   'id': 1,
  ///   'title': 'Post Title',
  ///   'body': 'Post body content',
  /// };
  /// final post = PostModel.fromJson(json);
  /// ```
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  /// Constructs a list of [PostModel] instances from a JSON list.
  ///
  /// The provided [jsonList] should be a list of maps, where each map
  /// represents a JSON object corresponding to a [PostModel].
  ///
  /// Example:
  /// ```dart
  /// final jsonList = [
  ///   {
  ///     'userId': 1,
  ///     'id': 1,
  ///     'title': 'Post Title 1',
  ///     'body': 'Post body content 1',
  ///   },
  ///   {
  ///     'userId': 2,
  ///     'id': 2,
  ///     'title': 'Post Title 2',
  ///     'body': 'Post body content 2',
  ///   },
  /// ];
  /// final posts = PostModel.fromJsonList(jsonList);
  /// ```
  static List<PostModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => PostModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// The ID of the user who created this post.
  final int userId;

  /// The unique identifier of the post.
  final int id;

  /// The title of the post.
  final String title;

  /// The body content of the post.
  final String body;
}
