#!/bin/bash

# Ensure the script exits if any command fails
set -e

# Define variables for paths
INPUT_FILE="pigeons/comment_model.dart"
DART_OUT="lib/src/generated/comment_model.g.dart"
OBJC_HEADER_OUT="../comments_repository/ios/Classes/CommentModel.h"
OBJC_SOURCE_OUT="../comments_repository/ios/Classes/CommentModel.m"
KOTLIN_OUT="../comments_repository/android/src/main/kotlin/com/example/verygoodcore/CommentModel.kt"
SWIFT_OUT="../comments_repository/ios/Classes/CommentModel.swift"

# Run the pigeon command
dart run pigeon \
  --input "$INPUT_FILE" \
  --dart_out "$DART_OUT" \
  --objc_header_out "$OBJC_HEADER_OUT" \
  --objc_source_out "$OBJC_SOURCE_OUT" \
  --kotlin_out "$KOTLIN_OUT" \
  --swift_out "$SWIFT_OUT"

# Print success message
echo "Pigeon files generated successfully!"
