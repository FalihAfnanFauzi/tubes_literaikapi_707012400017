import 'package:flutter/material.dart';

class HalamanPenerbit extends StatelessWidget {
  const HalamanPenerbit({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0F7EAD);
    const accentColor = Color(0xFF1BABE2);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Portal Penerbit IKAPI'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kartu Ringkasan Penerbit
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryColor, accentColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pustaka Jaya Bandung',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'ID: IKAPI-JB-042',
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Total Saldo Royalti Penjualan', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 4),
                  const Text(
                    'Rp 14.850.000',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Permohonan pencairan dana royalti Rp 14.850.000 dikirim ke Admin IKAPI!'),
                              backgroundColor: Color(0xFF0F7EAD),
                            ),
                          );
                        },
                        icon: const Icon(Icons.account_balance_wallet_rounded, size: 18),
                        label: const Text('Tarik Saldo'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.receipt_long_rounded, size: 18, color: Colors.white),
                        label: const Text('Mutasi', style: TextStyle(color: Colors.white)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Grid Statistik Cepat
            const Text(
              'Status Kurasi & Katalog Karya',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard('Buku Aktif', '12 Judul', Icons.check_circle_outline_rounded, Colors.green),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricCard('Proses Kurasi', '2 Judul', Icons.hourglass_top_rounded, Colors.orange),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricCard('Total Terjual', '342 E-Book', Icons.trending_up_rounded, primaryColor),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tombol Unggah Naskah Baru
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              elevation: 1,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2FE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.cloud_upload_rounded, color: primaryColor),
                ),
                title: const Text('Unggah Naskah E-Book Baru', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: const Text('Format PDF/EPUB untuk dikurasi Tim Kurator IKAPI Jabar', style: TextStyle(fontSize: 12)),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Modul Unggah Naskah E-Book dibuka. Siap kirim ke Kurator IKAPI.'),
                      backgroundColor: primaryColor,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Riwayat Transaksi Midtrans Terkini
            const Text(
              'Riwayat Pembelian Masuk (Midtrans)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
            ),
            const SizedBox(height: 12),
            _buildRiwayatTile('Lembayung di Balik Parahyangan', 'Pembeli: Ahmad Fauzi', 'Rp 45.000', '10 Menit Lalu'),
            _buildRiwayatTile('Jejak Sang Pengelana Sunda', 'Pembeli: Rina Marlina', 'Rp 52.000', '1 Jam Lalu'),
            _buildRiwayatTile('Tatakrama Basa & Ki Sunda', 'Pembeli: Dadan W.', 'Rp 40.000', '3 Jam Lalu'),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 2),
          Text(title, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
        ],
      ),
    );
  }

  Widget _buildRiwayatTile(String judul, String pembeli, String harga, String waktu) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.check_circle_rounded, color: Colors.green),
        title: Text(judul, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        subtitle: Text('$pembeli • $waktu', style: const TextStyle(fontSize: 11, color: Colors.grey)),
        trailing: Text(harga, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F7EAD))),
      ),
    );
  }
}
