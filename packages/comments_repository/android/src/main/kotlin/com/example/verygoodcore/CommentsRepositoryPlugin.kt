package com.example.verygoodcore

import io.flutter.embedding.engine.plugins.FlutterPlugin

/** CommentsRepositoryPlugin */
class CommentsRepositoryPlugin : FlutterPlugin {
  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    // Register the Pigeon API implementation.
    // The generated CommentApi class should have a setup() static method.
    CommentApi.setUp(binding.binaryMessenger, CommentApiImpl())
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    // Remove the API handler when detaching.
    CommentApi.setUp(binding.binaryMessenger, null)
  }
}
