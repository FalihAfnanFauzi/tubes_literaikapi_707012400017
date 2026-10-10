import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  final Function(int)? onGantiTab;

  const HalamanBeranda({super.key, this.onGantiTab});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0F7EAD);
    const accentColor = Color(0xFF1BABE2);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Utama LiteraIKAPI
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
                  color: primaryColor.withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.verified_rounded, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text(
                            'IKAPI JAWA BARAT RESMI',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'LiteraIKAPI Platform',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Marketplace E-Book Legal, Akses Web Reader Terproteksi DRM & Transaksi Instan Midtrans.',
                  style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        if (onGantiTab != null) {
                          onGantiTab!(1); // Pindah ke tab Katalog
                        } else {
                          Navigator.pushNamed(context, AppRoutes.katalog);
                        }
                      },
                      icon: const Icon(Icons.explore_rounded, size: 16),
                      label: const Text('Buka Katalog'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.penerbit);
                      },
                      icon: const Icon(Icons.business_center_rounded, size: 16, color: Colors.white),
                      label: const Text('Portal Penerbit', style: TextStyle(color: Colors.white)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 4 Pilar Layanan LiteraIKAPI
          const Text(
            'Keunggulan Ekosistem Digital IKAPI',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _buildFeatureBadge('1.250+ E-Book Legal', 'Katalog Resmi Penerbit', Icons.menu_book_rounded, primaryColor),
              _buildFeatureBadge('85 Penerbit Jabar', 'Verifikasi IKAPI Jabar', Icons.domain_verification_rounded, Colors.teal),
              _buildFeatureBadge('LiteraDRM™ Proteksi', 'Anti-Pembajakan Dokumen', Icons.security_rounded, Colors.indigo),
              _buildFeatureBadge('Midtrans Payment', 'Transaksi Instan Real-time', Icons.bolt_rounded, Colors.orange.shade800),
            ],
          ),
          const SizedBox(height: 20),

          // Tombol Navigasi Cepat & Pengujian Rute
          const Text(
            'Menu Navigasi & Pengujian Sistem',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildNavCard(
                  context,
                  'Koleksi Baca',
                  'E-book tersimpan',
                  Icons.auto_stories_rounded,
                  primaryColor,
                  () {
                    if (onGantiTab != null) {
                      onGantiTab!(2); // Pindah ke tab Koleksi
                    } else {
                      Navigator.pushNamed(context, AppRoutes.koleksiBaca);
                    }
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildNavCard(
                  context,
                  'Tentang IKAPI',
                  'Visi & pengembang',
                  Icons.info_outline_rounded,
                  accentColor,
                  () => Navigator.pushNamed(context, AppRoutes.tentang),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildNavCard(
                  context,
                  'Uji Rute 404',
                  'onUnknownRoute',
                  Icons.bug_report_rounded,
                  Colors.redAccent,
                  () => Navigator.pushNamed(context, '/rute_salah_tidak_ada'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Rekomendasi Buku Unggulan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Buku Unggulan Pekan Ini',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
              ),
              TextButton(
                onPressed: () {
                  if (onGantiTab != null) onGantiTab!(1);
                },
                child: const Text('Lihat Semua', style: TextStyle(color: primaryColor)),
              ),
            ],
          ),
          const SizedBox(height: 8),

          _buildRekomendasiItem(
            context,
            'Lembayung di Balik Parahyangan',
            'R. Kartawisastra',
            'Pustaka Jaya Bandung (IKAPI)',
            'Rp 45.000',
            'Fiksi & Sastra',
            '4.9',
            'Kisah inspiratif tentang perjuangan pemuda Priangan.',
            primaryColor,
          ),
          const SizedBox(height: 10),
          _buildRekomendasiItem(
            context,
            'Pemrograman Mobile Modern dengan Flutter',
            'Tim Dosen Informatika Telkom',
            'Telkom University Press (IKAPI)',
            'Rp 75.000',
            'Pendidikan & Sains',
            '5.0',
            'Buku referensi komprehensif mengulas widget, named routes, & responsive layout.',
            primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureBadge(String title, String desc, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  desc,
                  style: const TextStyle(fontSize: 9, color: Color(0xFF64748B)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavCard(
    BuildContext context,
    String title,
    String desc,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              desc,
              style: const TextStyle(fontSize: 9, color: Color(0xFF64748B)),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRekomendasiItem(
    BuildContext context,
    String judul,
    String penulis,
    String penerbit,
    String harga,
    String kategori,
    String rating,
    String sinopsis,
    Color primaryColor,
  ) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: Container(
          width: 48,
          height: 60,
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(Icons.book_rounded, color: primaryColor, size: 28),
        ),
        title: Text(judul, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Text('$penulis • $harga', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
        onTap: () async {
          final hasil = await Navigator.pushNamed(
            context,
            AppRoutes.detailBuku,
            arguments: {
              'judul': judul,
              'penulis': penulis,
              'penerbit': penerbit,
              'harga': harga,
              'kategori': kategori,
              'rating': rating,
              'sinopsis': sinopsis,
            },
          );
          if (hasil != null && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$hasil'),
                backgroundColor: primaryColor,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 4),
              ),
            );
          }
        },
      ),
    );
  }
}
