import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class HalamanGalat404 extends StatelessWidget {
  final String namaRute;

  const HalamanGalat404({
    super.key,
    required this.namaRute,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0F7EAD);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Rute Tidak Dikenal'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline_rounded,
                  size: 80,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Galat 404: Halaman Tidak Ditemukan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Rute navigasi "$namaRute" tidak terdaftar pada tabel Named Routes LiteraIKAPI.',
                style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Mekanisme onUnknownRoute berhasil mengamankan kestabilan aplikasi agar tidak mengalami crash.',
                style: TextStyle(fontSize: 12, color: primaryColor, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.beranda,
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.home_rounded),
                label: const Text('Kembali ke Beranda'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius borderRadius(double r) => BorderRadius.circular(r);
}
