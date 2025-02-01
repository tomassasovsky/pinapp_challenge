// import 'package:comments_repository/comments_repository.dart';
// import 'package:comments_repository_platform_interface/comments_repository_platform_interface.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockCommentsRepositoryPlatform extends Mock
//     with MockPlatformInterfaceMixin
//     implements CommentsRepositoryPlatform {}

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   group('CommentsRepository', () {
//     late CommentsRepositoryPlatform commentsRepositoryPlatform;

//     setUp(() {
//       commentsRepositoryPlatform = MockCommentsRepositoryPlatform();
//       CommentsRepositoryPlatform.instance = commentsRepositoryPlatform;
//     });

//     group('getPlatformName', () {
//       test('returns correct name when platform implementation exists',
//           () async {
//         const platformName = '__test_platform__';
//         when(
//           () => commentsRepositoryPlatform.getPlatformName(),
//         ).thenAnswer((_) async => platformName);

//         final actualPlatformName = await getPlatformName();
//         expect(actualPlatformName, equals(platformName));
//       });

//       test('throws exception when platform implementation is missing',
//           () async {
//         when(
//           () => commentsRepositoryPlatform.getPlatformName(),
//         ).thenAnswer((_) async => null);

//         expect(getPlatformName, throwsException);
//       });
//     });
//   });
// }
