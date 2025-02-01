dart run pigeon \                                             
  --input pigeons/comment_model.dart \
  --dart_out lib/src/generated/comment_model.g.dart \
  --objc_header_out ../comments_repository/ios/Classes/CommentModel.h \
  --objc_source_out ../comments_repository/ios/Classes/CommentModel.m \
  --kotlin_out ../comments_repository/android/src/main/kotlin/com/example/verygoodcore/CommentModel.kt \
  --swift_out ../comments_repository/ios/Classes/CommentModel.swift