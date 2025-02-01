# Comments Repository Plugin

A Flutter plugin that provides an interface for fetching comments from a remote API using platform-native implementations via Pigeon.

## Features
- Native platform integration using Pigeon.
- Fetch comments for a given post ID from an API.
- Configurable API base URL.
- Asynchronous operations to avoid UI blocking.
- Implementations in Swift (iOS) and Kotlin (Android).

## Installation

Add the plugin to your `pubspec.yaml`:

```yaml
dependencies:
  comments_repository:
    git:
      url: https://github.com/tomassasovsky/pinapp_challenge.git
      path: packages/comments_repository
```

Run:

```sh
dart pub get
```

## Usage

### Import the package

```dart
import 'package:comments_repository/comments_repository.dart';
```

### Initialize the repository

#### Using the default API settings:
```dart
final repository = CommentsRepository.standard();
```

#### Using a custom API base URL:
```dart
final repository = CommentsRepository.selfHosted(
  scheme: 'https',
  authority: 'your-api.com',
  port: 443,
);
```

### Fetch comments for a post
```dart
void fetchComments(int postId) async {
  try {
    final comments = await repository.getComments(postId: postId);
    print('Fetched ${comments.length} comments');
  } catch (e) {
    print('Error fetching comments: $e');
  }
}
```

## Native Implementations

### iOS (Swift)
The iOS implementation fetches comments using `URLSession` in `CommentApiImpl.swift`.

### Android (Kotlin)
The Android implementation uses `HttpURLConnection` and coroutines in `CommentApiImpl.kt`.

## Code Generation

This plugin uses Pigeon to generate platform channels. If you modify `pigeons/comment_model.dart`, regenerate the platform-specific files using:

```sh
bash generate_pigeon_models.sh
```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
