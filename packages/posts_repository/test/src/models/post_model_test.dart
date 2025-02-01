import 'package:flutter_test/flutter_test.dart';
import 'package:posts_repository/posts_repository.dart';

void main() {
  group('PostModel', () {
    test('fromJson creates a valid PostModel instance', () {
      final json = <String, dynamic>{
        'userId': 1,
        'id': 1,
        'title': 'Post Title',
        'body': 'Post body content',
      };

      final post = PostModel.fromJson(json);

      expect(post.userId, equals(1));
      expect(post.id, equals(1));
      expect(post.title, equals('Post Title'));
      expect(post.body, equals('Post body content'));
    });

    test('fromJsonList creates a list of PostModel instances', () {
      final jsonList = <dynamic>[
        {
          'userId': 1,
          'id': 1,
          'title': 'Post Title 1',
          'body': 'Post body content 1',
        },
        {
          'userId': 2,
          'id': 2,
          'title': 'Post Title 2',
          'body': 'Post body content 2',
        }
      ];

      final posts = PostModel.fromJsonList(jsonList);

      expect(posts, isA<List<PostModel>>());
      expect(posts.length, equals(2));

      expect(posts[0].userId, equals(1));
      expect(posts[0].id, equals(1));
      expect(posts[0].title, equals('Post Title 1'));
      expect(posts[0].body, equals('Post body content 1'));

      expect(posts[1].userId, equals(2));
      expect(posts[1].id, equals(2));
      expect(posts[1].title, equals('Post Title 2'));
      expect(posts[1].body, equals('Post body content 2'));
    });

    test('fromJson throws when required keys are missing', () {
      final incompleteJson = <String, dynamic>{
        'userId': 1,
        'id': 1,
      };

      expect(
        () => PostModel.fromJson(incompleteJson),
        throwsA(isA<TypeError>()),
      );
    });

    test('fromJsonList throws when one of the items is not a Map', () {
      final invalidJsonList = <dynamic>[
        {
          'userId': 1,
          'id': 1,
          'title': 'Post Title 1',
          'body': 'Post body content 1',
        },
        'Not a map',
      ];

      expect(
        () => PostModel.fromJsonList(invalidJsonList),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
