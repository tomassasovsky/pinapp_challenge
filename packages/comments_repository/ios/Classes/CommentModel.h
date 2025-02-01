// Autogenerated from Pigeon (v22.7.4), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class CommentModel;

/// Data class representing a comment.
///
/// This model is used to transfer comment data between Flutter and the
/// native platform implementations.
@interface CommentModel : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithPostId:(NSInteger )postId
    id:(NSInteger )id
    name:(NSString *)name
    email:(NSString *)email
    body:(NSString *)body;
@property(nonatomic, assign) NSInteger  postId;
@property(nonatomic, assign) NSInteger  id;
@property(nonatomic, copy) NSString * name;
@property(nonatomic, copy) NSString * email;
@property(nonatomic, copy) NSString * body;
@end

/// The codec used by all APIs.
NSObject<FlutterMessageCodec> *nullGetCommentModelCodec(void);

/// Host API for fetching comments from the native side.
///
/// This interface defines methods that Flutter can call to communicate with
/// native platform code. The implementation of these methods will be handled
/// natively on iOS (Swift) and Android (Kotlin).
@protocol CommentApi
/// Sets the base URL configuration for the API requests.
///
/// This method should be implemented natively to store the given
/// values (`scheme`, `authority`, and `port`), which will be used
/// to construct API request URLs.
///
/// - Parameters:
///   - [scheme]: The URL scheme (e.g., "http" or "https").
///   - [authority]: The host (e.g., "jsonplaceholder.typicode.com").
///   - [port]: The port number (e.g., 443 for HTTPS, 80 for HTTP).
- (void)setBaseUrlScheme:(NSString *)scheme authority:(NSString *)authority port:(NSInteger)port error:(FlutterError *_Nullable *_Nonnull)error;
/// Asynchronously fetches a list of [CommentModel] instances for a given
/// post ID.
///
/// This method is annotated with `@async`, which instructs Pigeon to generate
/// an asynchronous API on the Flutter side. Instead of returning a direct
/// result, the method will return a `Future<List<CommentModel>>`, allowing
/// the caller to await the response asynchronously.
///
/// ### Impact of `@async` on Native Implementations:
/// - **Swift (iOS)**: The generated Swift method will use a completion
///   handler (`completion: @escaping (Result<[CommentModel], Error>)
///   -> Void`), meaning that the native implementation must execute the
///   network request asynchronously and invoke the completion handler once
///   the data is available.
///
/// - **Kotlin (Android)**: The method signature will include a callback
///   parameter (`callback: (Result<List<CommentModel>>) -> Unit`), requiring
///   the native implementation to execute the network call in a coroutine
///   and return the result asynchronously.
///
/// - **Flutter (Dart)**: The generated Dart method will return a
///   `Future<List<CommentModel>>`, ensuring that calls to `getComments()` do
///   not block the main UI thread.
///
/// - Parameters:
///   - [postId]: The ID of the post whose comments should be retrieved.
///
/// - Returns: A `Future<List<CommentModel>>` resolving to the list of
///   comments.
- (void)getCommentsPostId:(NSInteger)postId completion:(void (^)(NSArray<CommentModel *> *_Nullable, FlutterError *_Nullable))completion;
@end

extern void SetUpCommentApi(id<FlutterBinaryMessenger> binaryMessenger, NSObject<CommentApi> *_Nullable api);

extern void SetUpCommentApiWithSuffix(id<FlutterBinaryMessenger> binaryMessenger, NSObject<CommentApi> *_Nullable api, NSString *messageChannelSuffix);

NS_ASSUME_NONNULL_END
