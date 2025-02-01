import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pinapp_challenge/l10n/l10n.dart';
import 'package:pinapp_challenge/retry_widget.dart';

// Fake L10n implementation
class FakeL10nImpl implements AppLocalizations {
  @override
  String get failedToLoadComments => 'Failed to load comments';

  @override
  String commentsForPost(Object postId) => 'Comments for Post $postId';

  @override
  String postedBy(Object email) => 'Posted by $email';

  @override
  String get failedToLoadPosts => 'Failed to load posts';

  @override
  String get localeName => 'en';

  @override
  String get posts => 'Posts';

  @override
  String get retry => 'Retry';
}

// Fake L10n delegate
class FakeL10nDelegate extends LocalizationsDelegate<AppLocalizations> {
  const FakeL10nDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<AppLocalizations> load(Locale locale) async => FakeL10nImpl();

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

void main() {
  testWidgets('renders error message and retry button, and calls onRetry',
      (tester) async {
    var retried = false;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [FakeL10nDelegate()],
        supportedLocales: const [Locale('en')],
        home: Scaffold(
          body: RetryWidget(
            errorMessage: 'Error occurred',
            onRetry: () => retried = true,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify the error message appears.
    expect(find.text('Error occurred'), findsOneWidget);
    // Verify the retry button text.
    expect(find.text('Retry'), findsOneWidget);

    // Tap the retry button.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(retried, isTrue);
  });
}
