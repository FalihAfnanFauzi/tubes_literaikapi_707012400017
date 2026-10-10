import 'package:flutter/material.dart';

class HalamanKoleksiBaca extends StatelessWidget {
  final bool isStandalone;

  const HalamanKoleksiBaca({super.key, this.isStandalone = false});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0F7EAD);

    Widget bodyContent = ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2FE),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFBAE6FD)),
          ),
          child: const Row(
            children: [
              Icon(Icons.cloud_done_rounded, color: primaryColor),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  '3 E-Book tersinkronisasi offline di Web Reader LiteraDRM™. Anda dapat membaca kapan saja tanpa kuota.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF0369A1)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Sedang Dibaca Terakhir Kali',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
        ),
        const SizedBox(height: 10),
        _buildKoleksiCard(
          context,
          'Lembayung di Balik Parahyangan',
          'R. Kartawisastra',
          'Pustaka Jaya Bandung',
          'Progres: Bab 4 (Halaman 84 / 240)',
          0.35,
          primaryColor,
        ),
        const SizedBox(height: 16),
        const Text(
          'Daftar Pustaka Saya',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
        ),
        const SizedBox(height: 10),
        _buildKoleksiCard(
          context,
          'Pemrograman Mobile Modern dengan Flutter',
          'Tim Dosen Informatika Telkom',
          'Telkom University Press',
          'Progres: Bab 7 (Halaman 150 / 320)',
          0.47,
          primaryColor,
        ),
        const SizedBox(height: 10),
        _buildKoleksiCard(
          context,
          'Tatakrama Basa & Kearifan Ki Sunda',
          'Budi Rahayu Tamsyah',
          'Geger Sunten',
          'Selesai Dibaca 100%',
          1.0,
          Colors.green,
        ),
      ],
    );

    // BottomAppBar dengan FAB sesuai modul praktikum
    Widget pageScaffold = Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Koleksi E-Book Saya'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: bodyContent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Fitur Catatan & Anotasi Digital E-Book diaktifkan.'),
              backgroundColor: primaryColor,
            ),
          );
        },
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        tooltip: 'Tambah Catatan Baca',
        child: const Icon(Icons.edit_note_rounded, size: 28),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.white,
        elevation: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.bookmark_rounded),
              color: primaryColor,
              tooltip: 'Penanda Buku',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Penanda buku (Bookmark) disimpan pada bab aktif.')),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.search_rounded),
              color: const Color(0xFF64748B),
              tooltip: 'Pencarian Bab/Teks',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pencarian kata kunci pada e-book aktif dibuka.')),
                );
              },
            ),
            const SizedBox(width: 48), // Ruang untuk center docked FAB
            IconButton(
              icon: const Icon(Icons.text_fields_rounded),
              color: const Color(0xFF64748B),
              tooltip: 'Pengaturan Ukuran Font',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pengaturan tipografi & ukuran font e-book disesuaikan.')),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.dark_mode_rounded),
              color: const Color(0xFF64748B),
              tooltip: 'Mode Baca Gelap / Sepia',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mode baca Sepia & Night Mode aktif untuk kenyamanan mata.')),
                );
              },
            ),
          ],
        ),
      ),
    );

    return pageScaffold;
  }

  Widget _buildKoleksiCard(
    BuildContext context,
    String judul,
    String penulis,
    String penerbit,
    String status,
    double progress,
    Color accentColor,
  ) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 45,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F7EAD).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.menu_book_rounded, color: Color(0xFF0F7EAD), size: 30),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        judul,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 2),
                      Text('Oleh: $penulis', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(penerbit, style: const TextStyle(fontSize: 11, color: Color(0xFF0F7EAD))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade200,
                color: accentColor,
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(status, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Membuka Web Reader untuk "$judul"...')),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 24),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('Lanjut Baca', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
