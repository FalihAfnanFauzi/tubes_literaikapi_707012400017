import 'package:flutter/material.dart';
import '../pages/halaman_detail_buku.dart';
import '../pages/halaman_galat_404.dart';
import '../pages/halaman_katalog.dart';
import '../pages/halaman_koleksi_baca.dart';
import '../pages/halaman_penerbit.dart';
import '../pages/halaman_tentang.dart';
import '../pages/halaman_form_naskah.dart';
import '../pages/halaman_peta_ikapi.dart';
import '../pages/halaman_statistik_royalti.dart';
import '../pages/halaman_tanya_redaksi.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String katalog = '/katalog';
  static const String detailBuku = '/detail_buku';
  static const String penerbit = '/penerbit';
  static const String koleksiBaca = '/koleksi_baca';
  static const String tentang = '/tentang';
  static const String galat404 = '/galat_404';
  static const String formNaskah = '/form_naskah';
  static const String petaIKAPI = '/peta_ikapi';
  static const String statistikRoyalti = '/statistik_royalti';
  static const String tanyaRedaksi = '/tanya_redaksi';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      katalog: (context) => const HalamanKatalog(),
      penerbit: (context) => const HalamanPenerbit(),
      koleksiBaca: (context) => const HalamanKoleksiBaca(),
      tentang: (context) => const HalamanTentang(),
      formNaskah: (context) => const HalamanFormNaskah(),
      petaIKAPI: (context) => const HalamanPetaIKAPI(),
      statistikRoyalti: (context) => const HalamanStatistikRoyalti(),
      tanyaRedaksi: (context) => const HalamanTanyaRedaksi(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == detailBuku) {
      final args = settings.arguments as Map<String, dynamic>? ?? {};
      return MaterialPageRoute(
        builder: (context) => HalamanDetailBuku(
          judul: args['judul'] ?? 'Judul Buku',
          penulis: args['penulis'] ?? 'Penulis Tidak Diketahui',
          penerbit: args['penerbit'] ?? 'Penerbit IKAPI',
          harga: args['harga'] ?? 'Rp 0',
          kategori: args['kategori'] ?? 'Umum',
          sinopsis: args['sinopsis'] ?? 'Sinopsis buku belum tersedia.',
          rating: args['rating'] ?? '4.8',
        ),
      );
    }
    return null;
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => HalamanGalat404(
        namaRute: settings.name ?? 'Rute Anonim',
      ),
    );
  }
}
