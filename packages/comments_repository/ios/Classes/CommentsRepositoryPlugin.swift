import Flutter
import UIKit

public class CommentsRepositoryPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    // Existing MethodChannel registration (if you still need it)
    let channel = FlutterMethodChannel(name: "comments_repository_ios", binaryMessenger: registrar.messenger())
    let instance = CommentsRepositoryPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    CommentApiSetup.setUp(binaryMessenger: registrar.messenger(), api: CommentApiImpl())
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS")
  }
}
