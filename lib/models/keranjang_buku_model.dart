import 'package:flutter/foundation.dart';

class KeranjangBukuModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _daftarItem = [];

  List<Map<String, dynamic>> get daftarItem => List.unmodifiable(_daftarItem);

  int get totalItem => _daftarItem.length;

  int get totalHargaNominal {
    int total = 0;
    for (final item in _daftarItem) {
      final hargaStr = item['harga']?.toString() ?? '0';
      // Hapus karakter non-digit untuk mengambil nilai numerik
      final angka = int.tryParse(hargaStr.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      total += angka;
    }
    return total;
  }

  String get totalHargaFormat {
    final nominal = totalHargaNominal;
    final buffer = StringBuffer();
    final str = nominal.toString();
    int hitung = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      hitung++;
      buffer.write(str[i]);
      if (hitung % 3 == 0 && i != 0) {
        buffer.write('.');
      }
    }
    return 'Rp ${buffer.toString().split('').reversed.join()}';
  }

  bool adaDiKeranjang(String judul) {
    return _daftarItem.any((buku) => buku['judul'] == judul);
  }

  bool tambahBuku(Map<String, dynamic> buku) {
    final judul = buku['judul']?.toString() ?? '';
    if (adaDiKeranjang(judul)) {
      return false; // Buku sudah ada di keranjang
    }
    _daftarItem.add(Map<String, dynamic>.from(buku));
    notifyListeners();
    return true;
  }

  void hapusBuku(String judul) {
    _daftarItem.removeWhere((buku) => buku['judul'] == judul);
    notifyListeners();
  }

  void kosongkan() {
    _daftarItem.clear();
    notifyListeners();
  }
}
