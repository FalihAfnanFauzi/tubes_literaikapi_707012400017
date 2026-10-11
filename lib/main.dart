import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/keranjang_buku_model.dart';
import 'models/favorit_buku_model.dart';
import 'navigation/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KeranjangBukuModel()),
        ChangeNotifierProvider(create: (_) => FavoritBukuModel()),
      ],
      child: const AplikasiLiteraIKAPI(),
    ),
  );
}

class AplikasiLiteraIKAPI extends StatelessWidget {
  const AplikasiLiteraIKAPI({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0F7EAD);
    const accentColor = Color(0xFF1BABE2);

    return MaterialApp(
      title: 'LiteraIKAPI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: accentColor,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: false,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      initialRoute: AppRoutes.beranda,
      routes: AppRoutes.daftarRoute(),
      onGenerateRoute: AppRoutes.bentukRoute,
      onUnknownRoute: AppRoutes.routeTidakDikenal,
    );
  }
}
