import 'package:assessment/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App launches and shows PulseNow title',
          (WidgetTester tester) async {
        await tester.pumpWidget(const PulseNowApp());
        await tester.pumpAndSettle();

        expect(find.text('PulseNow'), findsOneWidget);
      });
}
