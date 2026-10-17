import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tubes_literaikapi_707012400017/main.dart';
import 'package:tubes_literaikapi_707012400017/models/keranjang_buku_model.dart';
import 'package:tubes_literaikapi_707012400017/models/favorit_buku_model.dart';
import 'package:tubes_literaikapi_707012400017/models/kurasi_naskah_model.dart';
import 'package:tubes_literaikapi_707012400017/models/pesan_redaksi_model.dart';

void main() {
  testWidgets('LiteraIKAPI smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => KeranjangBukuModel()),
          ChangeNotifierProvider(create: (_) => FavoritBukuModel()),
          ChangeNotifierProvider(create: (_) => KurasiNaskahModel()),
          ChangeNotifierProvider(create: (_) => PesanRedaksiModel()),
        ],
        child: const AplikasiLiteraIKAPI(),
      ),
    );
    expect(find.byType(AplikasiLiteraIKAPI), findsOneWidget);
  });
}
