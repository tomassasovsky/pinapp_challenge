import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:posts_repository/posts_repository.dart';
import 'package:posts_repository/src/models/typedefs.dart';

/// {@template posts_repository}
/// A repository for fetching posts from a REST API.
///
/// This repository supports two configurations:
/// - [PostsRepository.standard] uses the default production API settings.
/// - [PostsRepository.selfHosted] allows for a custom scheme, host, and port.
///
/// A custom [http.Client] can be provided (defaulting to a new instance if not
/// provided) to allow for testing or customization of HTTP behavior.
/// {@endtemplate}
class PostsRepository {
  /// Creates a self-hosted instance of [PostsRepository].
  ///
  /// The [scheme], [authority], and [port] must be provided.
  /// An optional [httpClient] can be injected (for example, during testing).
  PostsRepository.selfHosted({
    required this.scheme,
    required this.authority,
    required this.port,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// Creates a standard instance of [PostsRepository] using production API
  /// settings.
  ///
  /// Optionally, an [httpClient] can be injected.
  PostsRepository.standard({http.Client? httpClient})
      : scheme = 'https',
        authority = 'jsonplaceholder.typicode.com',
        port = 443,
        _httpClient = httpClient ?? http.Client();

  /// The scheme of the API (for example, `http` or `https`).
  final String scheme;

  /// The authority (host) of the API.
  final String authority;

  /// The port number of the API.
  final int port;

  final http.Client _httpClient;

  /// Returns a list of posts by performing an HTTP GET on `/posts`.
  ///
  /// The response is expected to be a JSON array which is parsed into a list
  /// of [PostModel] objects.
  ///
  /// Throws an [HttpException] if the request fails or returns a non‑2xx
  /// status.
  ///
  /// Throws a [FormatException] if the response body is not a JSON array.
  Future<List<PostModel>> getPosts() async {
    final response = await _get<JSONLIST>(
      Uri(
        scheme: scheme,
        host: authority,
        port: port,
        path: '/posts',
      ),
    );

    return PostModel.fromJsonList(response);
  }

  /// Sends an HTTP GET request to the provided [uri] and returns a parsed
  /// response.
  ///
  /// The generic type [T] specifies the expected type of the decoded response,
  /// which is either a [JSON] (i.e., [Map<String, dynamic>]) or a [JSONLIST]
  /// (i.e., [List<Map<String, dynamic>>]).
  Future<T> _get<T>(Uri uri) async {
    http.Response response;

    try {
      response = await _httpClient.get(uri);
    } on SocketException {
      rethrow;
    } on TimeoutException {
      rethrow;
    } on Exception catch (exception) {
      throw HttpException(exception.toString());
    }

    return _handleResponse<T>(response);
  }

  /// Handles the HTTP [response] by checking the status code and decoding its
  /// body.
  ///
  /// If the [response] does not have a 2xx status code, an [HttpException] is
  /// thrown. Otherwise, the body is decoded from JSON and returned as type [T].
  /// Supported types for [T] are [JSON] (a [Map<String, dynamic>]) and
  /// [JSONLIST] (a [List<Map<String, dynamic>>]).
  T _handleResponse<T>(http.Response response) {
    // Immediately check the status code and throw an exception for non‑2xx
    // responses.
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        'Request failed with status: ${response.statusCode}',
        uri: response.request?.url,
      );
    }

    // Proceed to decode only if the status code indicates success.
    final dynamic decodedResponse = jsonDecode(response.body);

    if (decodedResponse is T) return decodedResponse;

    if (T == JSON) {
      return (decodedResponse as Map).cast<String, dynamic>() as T;
    } else if (T == JSONLIST) {
      final newResponse = (decodedResponse as List)
          .map<JSON>(
            (dynamic item) => (item as Map).cast<String, dynamic>(),
          )
          .toList();
      return newResponse as T;
    }

    return decodedResponse as T;
  }

  /// Closes the internal HTTP client.
  ///
  /// This should be called when the repository is no longer needed.
  void close() {
    _httpClient.close();
  }
}
