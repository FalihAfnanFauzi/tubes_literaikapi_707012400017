import 'package:flutter_test/flutter_test.dart';
import 'package:tubes_literaikapi_707012400017/main.dart';

void main() {
  testWidgets('LiteraIKAPI smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AplikasiLiteraIKAPI());
    expect(find.text('LiteraIKAPI Platform'), findsOneWidget);
  });
}
