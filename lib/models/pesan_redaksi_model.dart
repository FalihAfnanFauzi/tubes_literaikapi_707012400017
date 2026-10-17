import 'package:flutter/foundation.dart';

class PesanRedaksi {
  final String id;
  final String pengirim; // 'penulis' atau 'redaksi'
  final String namaPengirim;
  final String teks;
  final String waktu;

  PesanRedaksi({
    required this.id,
    required this.pengirim,
    required this.namaPengirim,
    required this.teks,
    required this.waktu,
  });

  bool get isPenulis => pengirim == 'penulis';
}

class PesanRedaksiModel extends ChangeNotifier {
  final List<PesanRedaksi> _daftarPesan = [
    PesanRedaksi(
      id: 'MSG-01',
      pengirim: 'redaksi',
      namaPengirim: 'Redaksi IKAPI Jabar',
      teks: 'Sampurasun! Selamat datang di Layanan Konsultasi Kurasi LiteraIKAPI Jawa Barat. Ada yang bisa kami bantu terkait penerbitan karya Anda?',
      waktu: '09:15',
    ),
    PesanRedaksi(
      id: 'MSG-02',
      pengirim: 'penulis',
      namaPengirim: 'Falih Afnan Fauzi',
      teks: 'Halo Admin Redaksi, saya sudah mengajukan naskah buku "Smart Heritage Bandung Raya". Berapa lama proses kurasi dan enkripsi LiteraDRM-nya?',
      waktu: '09:20',
    ),
    PesanRedaksi(
      id: 'MSG-03',
      pengirim: 'redaksi',
      namaPengirim: 'Redaksi IKAPI Jabar',
      teks: 'Proses kurasi naskah memerlukan waktu 3-5 hari kerja oleh tim penelaah IKAPI Jabar. Setelah disetujui, proteksi LiteraDRM dan registrasi ISBN elektronik akan diproses dalam 24 jam.',
      waktu: '09:22',
    ),
  ];

  List<PesanRedaksi> get daftarPesan => List.unmodifiable(_daftarPesan);

  void kirimPesanPenulis(String teks) {
    if (teks.trim().isEmpty) return;

    final sekarang = DateTime.now();
    final jamStr = '${sekarang.hour.toString().padLeft(2, '0')}:${sekarang.minute.toString().padLeft(2, '0')}';

    final pesanBaru = PesanRedaksi(
      id: 'MSG-${DateTime.now().millisecondsSinceEpoch}',
      pengirim: 'penulis',
      namaPengirim: 'Falih Afnan Fauzi',
      teks: teks.trim(),
      waktu: jamStr,
    );

    _daftarPesan.add(pesanBaru);
    notifyListeners();

    // Simulasi respons otomatis dari redaksi
    Future.delayed(const Duration(milliseconds: 1200), () {
      final balasanOtomatis = PesanRedaksi(
        id: 'MSG-AUTO-${DateTime.now().millisecondsSinceEpoch}',
        pengirim: 'redaksi',
        namaPengirim: 'Redaksi IKAPI Jabar',
        teks: 'Terima kasih atas pesan Anda: "${teks.trim()}". Pertanyaan Anda telah dicatat oleh Dewan Kurator LiteraIKAPI. Kami akan segera menindaklanjuti!',
        waktu: jamStr,
      );
      _daftarPesan.add(balasanOtomatis);
      notifyListeners();
    });
  }
}
