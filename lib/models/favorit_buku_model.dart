import 'package:flutter/foundation.dart';

class FavoritBukuModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _daftarFavorit = [];

  List<Map<String, dynamic>> get daftarFavorit => List.unmodifiable(_daftarFavorit);

  int get totalFavorit => _daftarFavorit.length;

  bool apakahFavorit(String judul) {
    return _daftarFavorit.any((buku) => buku['judul'] == judul);
  }

  void toggleFavorit(Map<String, dynamic> buku) {
    final judul = buku['judul']?.toString() ?? '';
    if (apakahFavorit(judul)) {
      _daftarFavorit.removeWhere((item) => item['judul'] == judul);
    } else {
      _daftarFavorit.add(Map<String, dynamic>.from(buku));
    }
    notifyListeners();
  }

  void tambahFavorit(Map<String, dynamic> buku) {
    final judul = buku['judul']?.toString() ?? '';
    if (!apakahFavorit(judul)) {
      _daftarFavorit.add(Map<String, dynamic>.from(buku));
      notifyListeners();
    }
  }

  void hapusFavorit(String judul) {
    _daftarFavorit.removeWhere((item) => item['judul'] == judul);
    notifyListeners();
  }
}
