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
@interface CommentModel : NSObject
+ (instancetype)makeWithPostId:(nullable NSNumber *)postId
    id:(nullable NSNumber *)id
    name:(nullable NSString *)name
    email:(nullable NSString *)email
    body:(nullable NSString *)body;
@property(nonatomic, strong, nullable) NSNumber * postId;
@property(nonatomic, strong, nullable) NSNumber * id;
@property(nonatomic, copy, nullable) NSString * name;
@property(nonatomic, copy, nullable) NSString * email;
@property(nonatomic, copy, nullable) NSString * body;
@end

/// The codec used by all APIs.
NSObject<FlutterMessageCodec> *nullGetCommentModelCodec(void);

/// Host API for fetching comments from the native side.
///
/// This asynchronous method returns a list of [CommentModel] objects after
/// performing a REST API call natively.
@protocol CommentApi
/// Sets the base URL configuration.
/// The native side should store these values and use them to construct the
/// URL.
- (void)setBaseUrlScheme:(NSString *)scheme authority:(NSString *)authority port:(NSInteger)port error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns a list of [CommentModel] instances for the given postId.
///
/// @return `nil` only when `error != nil`.
- (nullable NSArray<CommentModel *> *)getCommentsPostId:(NSInteger)postId error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void SetUpCommentApi(id<FlutterBinaryMessenger> binaryMessenger, NSObject<CommentApi> *_Nullable api);

extern void SetUpCommentApiWithSuffix(id<FlutterBinaryMessenger> binaryMessenger, NSObject<CommentApi> *_Nullable api, NSString *messageChannelSuffix);

NS_ASSUME_NONNULL_END
