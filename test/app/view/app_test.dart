import 'package:flutter_test/flutter_test.dart';
import 'package:pinapp_challenge/app/app.dart';
import 'package:pinapp_challenge/counter/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
