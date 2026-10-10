import 'package:flutter/material.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0F7EAD);
    const accentColor = Color(0xFF1BABE2);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Tentang LiteraIKAPI'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 44),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'LiteraIKAPI Platform',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'E-Commerce & Digital Publishing Platform IKAPI Jawa Barat',
                    style: TextStyle(fontSize: 13, color: primaryColor, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Latar Belakang Masalah
            _buildSectionCard(
              'Latar Belakang & Solusi Permasalahan',
              'LiteraIKAPI dikembangkan untuk menyelesaikan permasalahan tingginya biaya cetak dan logistik buku fisik, terbatasnya jangkauan distribusi penerbit lokal di Jawa Barat, serta maraknya pembajakan dokumen digital. Melalui penyediaan akses baca terproteksi (web reader LiteraDRM™) dan transaksi instan terintegrasi Midtrans, penerbit lokal dapat berkembang mandiri secara berkelanjutan.',
              Icons.lightbulb_outline_rounded,
              accentColor,
            ),
            const SizedBox(height: 16),

            // 3 Pihak Pengguna Utama
            const Text(
              'Tiga Aktor Pengguna Utama',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
            ),
            const SizedBox(height: 12),
            _buildAktorTile(
              '1. Penerbit Anggota IKAPI Jabar',
              'Mempublikasikan katalog karya secara mandiri serta memantau saldo royalti penjualan secara transparan.',
              Icons.business_center_rounded,
              primaryColor,
            ),
            _buildAktorTile(
              '2. Pembaca / Masyarakat Umum',
              'Membeli dan menikmati e-book legal secara praktis, terjangkau, dan aman melalui web reader terproteksi.',
              Icons.people_alt_rounded,
              Colors.green.shade700,
            ),
            _buildAktorTile(
              '3. Administrator IKAPI',
              'Mengurasi kelayakan konten naskah sebelum terbit serta memvalidasi pencairan dana pendapatan penerbit.',
              Icons.admin_panel_settings_rounded,
              Colors.deepPurple,
            ),
            const SizedBox(height: 20),

            // Profil Pengembang Mahasiswa
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Informasi Pengembang', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 8),
                  Text('Nama: Falih Afnan Fauzi', style: TextStyle(fontSize: 13)),
                  Text('NIM: 707012400017', style: TextStyle(fontSize: 13)),
                  Text('Kelas: 48-03', style: TextStyle(fontSize: 13)),
                  Text('Program Studi: D4 Sistem Informasi Kota Cerdas', style: TextStyle(fontSize: 13)),
                  Text('Institusi: Universitas Telkom Bandung', style: TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, String desc, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1E293B)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            style: const TextStyle(fontSize: 13, height: 1.5, color: Color(0xFF475569)),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildAktorTile(String role, String desc, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(role, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        subtitle: Text(desc, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
      ),
    );
  }
}
