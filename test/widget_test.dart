import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tubes_literaikapi_707012400017/main.dart';
import 'package:tubes_literaikapi_707012400017/models/keranjang_buku_model.dart';
import 'package:tubes_literaikapi_707012400017/models/favorit_buku_model.dart';

void main() {
  testWidgets('LiteraIKAPI smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => KeranjangBukuModel()),
          ChangeNotifierProvider(create: (_) => FavoritBukuModel()),
        ],
        child: const AplikasiLiteraIKAPI(),
      ),
    );
    expect(find.byType(AplikasiLiteraIKAPI), findsOneWidget);
  });
}
