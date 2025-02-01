import Flutter
import UIKit

public class CommentsRepositoryPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    CommentApiSetup.setUp(binaryMessenger: registrar.messenger(), api: CommentApiImpl())
  }
}
