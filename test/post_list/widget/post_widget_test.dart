import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinapp_challenge/post_list/widget/post_widget.dart';
import 'package:posts_repository/posts_repository.dart';

class MockPostModel extends Mock implements PostModel {}

void main() {
  late PostModel post;

  setUp(() {
    post = MockPostModel();
    when(() => post.id).thenReturn(1);
    when(() => post.title).thenReturn('Test Title');
    when(() => post.body).thenReturn('Test Body');
  });

  testWidgets('renders PostWidget with title, body, and correct hero tag',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PostWidget(post),
        ),
      ),
    );

    // Verify that title and body text are displayed.
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Body'), findsOneWidget);

    // Verify that Hero widget is used with the correct tag.
    final heroFinder = find.byType(Hero);
    expect(heroFinder, findsOneWidget);
    final heroWidget = tester.widget<Hero>(heroFinder);
    expect(heroWidget.tag, equals(1));
  });

  testWidgets('calls onTap callback when tapped', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PostWidget(
            post,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    final inkwellFinder = find.byType(InkWell);
    expect(inkwellFinder, findsOneWidget);

    await tester.tap(inkwellFinder);
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });
}
