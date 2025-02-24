// Autogenerated from Pigeon (v22.7.4), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "CommentModel.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSArray<id> *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}

static id GetNullableObjectAtIndex(NSArray<id> *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

@interface CommentModel ()
+ (CommentModel *)fromList:(NSArray<id> *)list;
+ (nullable CommentModel *)nullableFromList:(NSArray<id> *)list;
- (NSArray<id> *)toList;
@end

@implementation CommentModel
+ (instancetype)makeWithPostId:(NSInteger )postId
    id:(NSInteger )id
    name:(NSString *)name
    email:(NSString *)email
    body:(NSString *)body {
  CommentModel* pigeonResult = [[CommentModel alloc] init];
  pigeonResult.postId = postId;
  pigeonResult.id = id;
  pigeonResult.name = name;
  pigeonResult.email = email;
  pigeonResult.body = body;
  return pigeonResult;
}
+ (CommentModel *)fromList:(NSArray<id> *)list {
  CommentModel *pigeonResult = [[CommentModel alloc] init];
  pigeonResult.postId = [GetNullableObjectAtIndex(list, 0) integerValue];
  pigeonResult.id = [GetNullableObjectAtIndex(list, 1) integerValue];
  pigeonResult.name = GetNullableObjectAtIndex(list, 2);
  pigeonResult.email = GetNullableObjectAtIndex(list, 3);
  pigeonResult.body = GetNullableObjectAtIndex(list, 4);
  return pigeonResult;
}
+ (nullable CommentModel *)nullableFromList:(NSArray<id> *)list {
  return (list) ? [CommentModel fromList:list] : nil;
}
- (NSArray<id> *)toList {
  return @[
    @(self.postId),
    @(self.id),
    self.name ?: [NSNull null],
    self.email ?: [NSNull null],
    self.body ?: [NSNull null],
  ];
}
@end

@interface nullCommentModelPigeonCodecReader : FlutterStandardReader
@end
@implementation nullCommentModelPigeonCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 129: 
      return [CommentModel fromList:[self readValue]];
    default:
      return [super readValueOfType:type];
  }
}
@end

@interface nullCommentModelPigeonCodecWriter : FlutterStandardWriter
@end
@implementation nullCommentModelPigeonCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[CommentModel class]]) {
    [self writeByte:129];
    [self writeValue:[value toList]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface nullCommentModelPigeonCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation nullCommentModelPigeonCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[nullCommentModelPigeonCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[nullCommentModelPigeonCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *nullGetCommentModelCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    nullCommentModelPigeonCodecReaderWriter *readerWriter = [[nullCommentModelPigeonCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}
void SetUpCommentApi(id<FlutterBinaryMessenger> binaryMessenger, NSObject<CommentApi> *api) {
  SetUpCommentApiWithSuffix(binaryMessenger, api, @"");
}

void SetUpCommentApiWithSuffix(id<FlutterBinaryMessenger> binaryMessenger, NSObject<CommentApi> *api, NSString *messageChannelSuffix) {
  messageChannelSuffix = messageChannelSuffix.length > 0 ? [NSString stringWithFormat: @".%@", messageChannelSuffix] : @"";
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
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.comments_repository.CommentApi.setBaseUrl", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetCommentModelCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setBaseUrlScheme:authority:port:error:)], @"CommentApi api (%@) doesn't respond to @selector(setBaseUrlScheme:authority:port:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray<id> *args = message;
        NSString *arg_scheme = GetNullableObjectAtIndex(args, 0);
        NSString *arg_authority = GetNullableObjectAtIndex(args, 1);
        NSInteger arg_port = [GetNullableObjectAtIndex(args, 2) integerValue];
        FlutterError *error;
        [api setBaseUrlScheme:arg_scheme authority:arg_authority port:arg_port error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
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
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.comments_repository.CommentApi.getComments", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetCommentModelCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getCommentsPostId:completion:)], @"CommentApi api (%@) doesn't respond to @selector(getCommentsPostId:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray<id> *args = message;
        NSInteger arg_postId = [GetNullableObjectAtIndex(args, 0) integerValue];
        [api getCommentsPostId:arg_postId completion:^(NSArray<CommentModel *> *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
