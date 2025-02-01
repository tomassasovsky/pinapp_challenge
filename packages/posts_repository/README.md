# Posts Repository

A Dart package for fetching posts from a JSON API, providing both standard and self-hosted configurations.

## Features
- Fetch posts from a REST API.
- Support for both standard (default API) and self-hosted configurations.
- Easy JSON parsing into `PostModel` objects.
- Customizable HTTP client for testing and advanced use cases.

## Installation
Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  posts_repository:
    git: https://github.com/tomassasovsky/pinapp_challenge.git
    path: packages/posts_repository
```

Then run:

```sh
dart pub get
```

## Usage

### Creating a Repository Instance

#### Standard API Configuration
```dart
final postsRepository = PostsRepository.standard();
```

#### Self-Hosted API Configuration
```dart
final postsRepository = PostsRepository.selfHosted(
  scheme: 'https',
  authority: 'your-api.com',
  port: 443,
);
```

### Fetching Posts
```dart
final posts = await postsRepository.getPosts();
for (var post in posts) {
  print('Post ID: ${post.id}, Title: ${post.title}');
}
```

### Closing the Repository
```dart
postsRepository.close();
```

## API Reference

### `PostModel`
A model representing a post retrieved from the API.

#### Properties:
- `userId`: The ID of the user who created the post.
- `id`: The unique identifier of the post.
- `title`: The title of the post.
- `body`: The body content of the post.

#### Creating a `PostModel` from JSON
```dart
final json = {
  'userId': 1,
  'id': 1,
  'title': 'Sample Post',
  'body': 'This is a post body.',
};
final post = PostModel.fromJson(json);
```

#### Creating a List of `PostModel` from JSON
```dart
final jsonList = [
  {'userId': 1, 'id': 1, 'title': 'Post 1', 'body': 'Content 1'},
  {'userId': 2, 'id': 2, 'title': 'Post 2', 'body': 'Content 2'},
];
final posts = PostModel.fromJsonList(jsonList);
```

## Error Handling
- Throws an `HttpException` if the request fails or returns a non-2xx status code.
- Handles network issues gracefully using Dart exceptions (`SocketException`, `TimeoutException`).

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
