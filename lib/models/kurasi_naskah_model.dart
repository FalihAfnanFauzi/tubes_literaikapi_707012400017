import 'package:flutter/foundation.dart';

class ItemNaskah {
  final String id;
  final String judul;
  final String penulis;
  final String email;
  final String kategori;
  final int halaman;
  final String sinopsis;
  final bool setujuDrm;
  final bool setujuRoyalti;
  String status; // 'Menunggu Kurasi', 'Disetujui Redaksi', 'Terbit Katalog'
  final String tanggalPengajuan;

  ItemNaskah({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.email,
    required this.kategori,
    required this.halaman,
    required this.sinopsis,
    required this.setujuDrm,
    required this.setujuRoyalti,
    this.status = 'Menunggu Kurasi',
    required this.tanggalPengajuan,
  });
}

class KurasiNaskahModel extends ChangeNotifier {
  final List<ItemNaskah> _daftarNaskah = [
    ItemNaskah(
      id: 'NSK-001',
      judul: 'Digitalisasi Naskah Kuno Sunda',
      penulis: 'Dr. Dadan Sutisna',
      email: 'dadan@literasi.id',
      kategori: 'Budaya Pasundan',
      halaman: 184,
      sinopsis: 'Kajian komprehensif pelestarian manuskrip lontar Sunda ke dalam format e-book interaktif bersertifikat LiteraDRM.',
      setujuDrm: true,
      setujuRoyalti: true,
      status: 'Terbit Katalog',
      tanggalPengajuan: '10/10/2026',
    ),
    ItemNaskah(
      id: 'NSK-002',
      judul: 'Smart Heritage Bandung Raya',
      penulis: 'Falih Afnan Fauzi',
      email: 'falih.afnan@telkomuniversity.ac.id',
      kategori: 'Pendidikan & Riset',
      halaman: 240,
      sinopsis: 'Rancangan integrasi cagar budaya ke dalam ekosistem smart tourism berbasis IoT dan mobile navigation.',
      setujuDrm: true,
      setujuRoyalti: true,
      status: 'Disetujui Redaksi',
      tanggalPengajuan: '12/10/2026',
    ),
    ItemNaskah(
      id: 'NSK-003',
      judul: 'Kabut Asmara Tangkuban Parahu',
      penulis: 'Ratih Purbasari',
      email: 'ratih@penerbit.org',
      kategori: 'Sastra & Fiksi',
      halaman: 156,
      sinopsis: 'Novel romansa berlatar sejarah Bandung era kolonial dan legenda Sangkuriang dengan sentuhan kontemporer.',
      setujuDrm: true,
      setujuRoyalti: true,
      status: 'Menunggu Kurasi',
      tanggalPengajuan: '13/10/2026',
    ),
  ];

  List<ItemNaskah> get daftarNaskah => List.unmodifiable(_daftarNaskah);

  int get totalNaskah => _daftarNaskah.length;
  int get totalDisetujui => _daftarNaskah.where((n) => n.status == 'Disetujui Redaksi' || n.status == 'Terbit Katalog').length;
  int get totalMenunggu => _daftarNaskah.where((n) => n.status == 'Menunggu Kurasi').length;

  int jumlahByKategori(String kategori) {
    return _daftarNaskah.where((n) => n.kategori.toLowerCase().contains(kategori.toLowerCase())).length;
  }

  void tambahNaskah(ItemNaskah naskah) {
    _daftarNaskah.insert(0, naskah);
    notifyListeners();
  }

  void ubahStatus(String id, String statusBaru) {
    final index = _daftarNaskah.indexWhere((n) => n.id == id);
    if (index != -1) {
      _daftarNaskah[index].status = statusBaru;
      notifyListeners();
    }
  }

  void hapusNaskah(String id) {
    _daftarNaskah.removeWhere((n) => n.id == id);
    notifyListeners();
  }
}
