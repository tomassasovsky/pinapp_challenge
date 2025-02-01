import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:posts_repository/posts_repository.dart';

void main() {
  group('PostsRepository', () {
    test(
      'getPosts returns a list of PostModel when HTTP response is valid',
      () async {
        final mockResponseData = [
          {
            'userId': 1,
            'id': 1,
            'title': 'Test Post 1',
            'body': 'Content of test post 1',
          },
          {
            'userId': 2,
            'id': 2,
            'title': 'Test Post 2',
            'body': 'Content of test post 2',
          }
        ];

        final mockClient = MockClient((request) async {
          return http.Response(jsonEncode(mockResponseData), 200);
        });

        // Use selfHosted with the mock client.
        final repository = PostsRepository.selfHosted(
          scheme: 'http',
          authority: 'example.com',
          port: 80,
          httpClient: mockClient,
        );

        final posts = await repository.getPosts();

        expect(posts, isA<List<PostModel>>());
        expect(posts.length, equals(2));
        expect(posts.first.id, equals(1));
        expect(posts.first.title, equals('Test Post 1'));

        repository.close();
      },
    );

    test('getPosts throws an HttpException on non-2xx response', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Server Error', 500);
      });

      final repository = PostsRepository.selfHosted(
        scheme: 'http',
        authority: 'example.com',
        port: 80,
        httpClient: mockClient,
      );

      expect(
        () async => repository.getPosts(),
        throwsA(isA<HttpException>()),
      );

      repository.close();
    });

    test('close properly closes the HTTP client', () {
      final mockClient = MockClient((request) async {
        return http.Response('[]', 200);
      });
      final repository = PostsRepository.selfHosted(
        scheme: 'http',
        authority: 'example.com',
        port: 80,
        httpClient: mockClient,
      );

      expect(repository.close, returnsNormally);
    });
  });
}
