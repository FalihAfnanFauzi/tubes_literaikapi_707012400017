import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class HalamanKatalog extends StatelessWidget {
  final bool isStandalone;

  const HalamanKatalog({super.key, this.isStandalone = false});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0F7EAD);
    const accentColor = Color(0xFF1BABE2);

    Widget content = DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: const TabBar(
              labelColor: primaryColor,
              unselectedLabelColor: Color(0xFF64748B),
              indicatorColor: primaryColor,
              indicatorWeight: 3,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              tabs: [
                Tab(icon: Icon(Icons.auto_stories_rounded), text: 'Fiksi & Sastra'),
                Tab(icon: Icon(Icons.school_rounded), text: 'Pendidikan'),
                Tab(icon: Icon(Icons.account_balance_rounded), text: 'Budaya Sunda'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildDaftarBuku(context, _bukuFiksi, primaryColor, accentColor),
                _buildDaftarBuku(context, _bukuPendidikan, primaryColor, accentColor),
                _buildDaftarBuku(context, _bukuBudaya, primaryColor, accentColor),
              ],
            ),
          ),
        ],
      ),
    );

    if (isStandalone) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Katalog E-Book IKAPI'),
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        body: content,
      );
    }

    return content;
  }

  Widget _buildDaftarBuku(
    BuildContext context,
    List<Map<String, dynamic>> daftar,
    Color primaryColor,
    Color accentColor,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: daftar.length,
      itemBuilder: (context, index) {
        final buku = daftar[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 1.5,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor.withValues(alpha: 0.8), accentColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(Icons.book_rounded, color: Colors.white, size: 36),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        buku['judul']!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Penulis: ${buku['penulis']}',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Penerbit: ${buku['penerbit']}',
                        style: TextStyle(fontSize: 11, color: primaryColor, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            buku['harga']!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final hasil = await Navigator.pushNamed(
                                context,
                                AppRoutes.detailBuku,
                                arguments: buku,
                              );
                              if (hasil != null && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        const Icon(Icons.check_circle_rounded, color: Colors.white),
                                        const SizedBox(width: 8),
                                        Expanded(child: Text('$hasil')),
                                      ],
                                    ),
                                    backgroundColor: primaryColor,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    duration: const Duration(seconds: 4),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Rincian & Beli', style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static const List<Map<String, dynamic>> _bukuFiksi = [
    {
      'judul': 'Lembayung di Balik Parahyangan',
      'penulis': 'R. Kartawisastra',
      'penerbit': 'Pustaka Jaya Bandung (IKAPI)',
      'harga': 'Rp 45.000',
      'kategori': 'Fiksi & Sastra',
      'rating': '4.9',
      'sinopsis':
          'Kisah inspiratif tentang perjuangan pemuda pedesaan Priangan dalam menempuh pendidikan modern tanpa melupakan akar budaya leluhurnya. Menghadirkan deskripsi alam Priangan yang memukau.',
    },
    {
      'judul': 'Jejak Sang Pengelana Sunda',
      'penulis': 'Dadan Sutisna',
      'penerbit': 'Kiblat Buku Utama (IKAPI)',
      'harga': 'Rp 52.000',
      'kategori': 'Fiksi & Sastra',
      'rating': '4.8',
      'sinopsis':
          'Novel petualangan epik yang berlatar abad ke-16 menyusuri aliran Sungai Citarum, membawa pesan persahabatan, keberanian, dan pelestarian lingkungan hidup Jawa Barat.',
    },
    {
      'judul': 'Misteri Kabut Tangkuban Parahu',
      'penulis': 'Siti Nurhaliza A.',
      'penerbit': 'Rosdakarya Publishing (IKAPI)',
      'harga': 'Rp 39.000',
      'kategori': 'Fiksi & Sastra',
      'rating': '4.7',
      'sinopsis':
          'Sebuah fiksi misteri remaja berlatar observatorium geologi di kaki gunung vulkanik Bandung Utara yang sarat dengan teka-teki ilmiah dan mitologi kearifan lokal.',
    },
  ];

  static const List<Map<String, dynamic>> _bukuPendidikan = [
    {
      'judul': 'Pemrograman Mobile Modern dengan Flutter',
      'penulis': 'Tim Dosen Informatika Telkom',
      'penerbit': 'Telkom University Press (IKAPI)',
      'harga': 'Rp 75.000',
      'kategori': 'Pendidikan & Sains',
      'rating': '5.0',
      'sinopsis':
          'Buku referensi komprehensif mengulas arsitektur widget Flutter, state management, named routes, responsive layout, integrasi Web API, dan deployment aplikasi Android & iOS.',
    },
    {
      'judul': 'Arsitektur Kota Cerdas & IoT Terpadu',
      'penulis': 'Dr. Ir. Hendra Gunawan, M.T.',
      'penerbit': 'Alfabeta Bandung (IKAPI)',
      'harga': 'Rp 88.000',
      'kategori': 'Pendidikan & Sains',
      'rating': '4.9',
      'sinopsis':
          'Kajian mendalam penerapan teknologi Internet of Things, kecerdasan buatan, dan tata kelola big data dalam mewujudkan ekosistem smart governance dan smart mobility perkotaan.',
    },
    {
      'judul': 'Ekonomi Digital & Model Monetisasi E-Book',
      'penulis': 'Ahmad Fauzi & Prof. Suryadi',
      'penerbit': 'Remaja Rosdakarya (IKAPI)',
      'harga': 'Rp 60.000',
      'kategori': 'Pendidikan & Sains',
      'rating': '4.8',
      'sinopsis':
          'Panduan praktis bagi penerbit dan penulis dalam bertransformasi digital, mengintegrasikan payment gateway, serta mengelola royalti berbasis platform marketplace modern.',
    },
  ];

  static const List<Map<String, dynamic>> _bukuBudaya = [
    {
      'judul': 'Tatakrama Basa & Kearifan Ki Sunda',
      'penulis': 'Budi Rahayu Tamsyah',
      'penerbit': 'Geger Sunten (IKAPI)',
      'harga': 'Rp 40.000',
      'kategori': 'Budaya Sunda & Jabar',
      'rating': '4.9',
      'sinopsis':
          'Koleksi rujukan otentik tata bahasa, undak-usuk basa Sunda, serta nilai-nilai silih asih, silih asah, dan silih asuh yang menjadi pilar peradaban masyarakat Jawa Barat.',
    },
    {
      'judul': 'Ensiklopedi Seni Tradisional Jawa Barat',
      'penulis': 'Prof. Dr. Arthur S. Nalan',
      'penerbit': 'Kiblat Buku Utama (IKAPI)',
      'harga': 'Rp 95.000',
      'kategori': 'Budaya Sunda & Jabar',
      'rating': '4.8',
      'sinopsis':
          'Dokumentasi visual dan catatan etnomusikologi lengkap mengenai seni wayang golek, angklung, jaipongan, tarawangsa, dan arsitektur rumah adat panggung di Jawa Barat.',
    },
    {
      'judul': 'Peta Kuliner & Sejarah Gastronomi Priangan',
      'penulis': 'Asep Saepudin, M.Hum.',
      'penerbit': 'Pustaka Setia (IKAPI)',
      'harga': 'Rp 50.000',
      'kategori': 'Budaya Sunda & Jabar',
      'rating': '4.7',
      'sinopsis':
          'Menelusuri sejarah kuliner khas Sunda sejak era kolonial hingga tren gastronomi modern, lengkap dengan filosofi kesegaran lalapan dan sambal khas tatar Sunda.',
    },
  ];
}
