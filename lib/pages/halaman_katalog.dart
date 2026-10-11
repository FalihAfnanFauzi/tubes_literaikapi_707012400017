import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/keranjang_buku_model.dart';
import '../models/favorit_buku_model.dart';
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
    final favoritModel = context.watch<FavoritBukuModel>();
    final keranjangModel = context.watch<KeranjangBukuModel>();

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: daftar.length,
      itemBuilder: (itemContext, index) {
        final buku = daftar[index];
        final judul = buku['judul'] ?? '';
        final isFavorit = favoritModel.apakahFavorit(judul);
        final diKeranjang = keranjangModel.adaDiKeranjang(judul);

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
                  height: 85,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              judul,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              isFavorit ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              color: isFavorit ? Colors.redAccent : Colors.grey.shade400,
                              size: 22,
                            ),
                            tooltip: isFavorit ? 'Hapus dari Wishlist' : 'Tambah ke Wishlist',
                            onPressed: () {
                              itemContext.read<FavoritBukuModel>().toggleFavorit(buku);
                              ScaffoldMessenger.of(itemContext).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isFavorit
                                        ? 'E-Book "$judul" dihapus dari Wishlist.'
                                        : 'E-Book "$judul" ditambahkan ke Wishlist!',
                                  ),
                                  duration: const Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          ),
                        ],
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
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  diKeranjang
                                      ? Icons.shopping_cart_rounded
                                      : Icons.add_shopping_cart_rounded,
                                  color: diKeranjang ? primaryColor : Colors.grey.shade600,
                                  size: 20,
                                ),
                                tooltip: diKeranjang ? 'Ada di Keranjang' : 'Tambah ke Keranjang',
                                onPressed: () {
                                  if (diKeranjang) {
                                    itemContext.read<KeranjangBukuModel>().hapusBuku(judul);
                                    ScaffoldMessenger.of(itemContext).showSnackBar(
                                      SnackBar(
                                        content: Text('E-Book "$judul" dikeluarkan dari keranjang.'),
                                        duration: const Duration(seconds: 2),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  } else {
                                    itemContext.read<KeranjangBukuModel>().tambahBuku(buku);
                                    ScaffoldMessenger.of(itemContext).showSnackBar(
                                      SnackBar(
                                        content: Text('E-Book "$judul" dimasukkan ke keranjang belanja!'),
                                        duration: const Duration(seconds: 2),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: primaryColor,
                                      ),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(width: 4),
                              ElevatedButton(
                                onPressed: () async {
                                  final hasil = await Navigator.pushNamed(
                                    itemContext,
                                    AppRoutes.detailBuku,
                                    arguments: buku,
                                  );
                                  if (hasil != null && itemContext.mounted) {
                                    ScaffoldMessenger.of(itemContext).showSnackBar(
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
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text('Detail', style: TextStyle(fontSize: 12)),
                              ),
                            ],
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
      'judul': 'Sang Guru di Kota Kembang',
      'penulis': 'Ahmad Fauzi Ridwan',
      'penerbit': 'Penerbit Rosda Bandung (IKAPI)',
      'harga': 'Rp 52.000',
      'kategori': 'Fiksi & Sastra',
      'rating': '4.8',
      'sinopsis':
          'Sebuah novel perjuangan pendidik pada dekade 1970-an di Bandung yang merintis perpustakaan keliling demi mencerdaskan generasi penerus bangsa.',
    },
    {
      'judul': 'Misteri Benteng Pasir Ipis Lembang',
      'penulis': 'Dewi Saraswati',
      'penerbit': 'Mizan Digital (IKAPI Jabar)',
      'harga': 'Rp 38.000',
      'kategori': 'Fiksi & Sastra',
      'rating': '4.7',
      'sinopsis':
          'Kisah petualangan sekelompok mahasiswa arkeologi yang meneliti peninggalan bersejarah kolonial di perbukitan Lembang dan mengungkap rahasia arsip naskah kuno.',
    },
  ];

  static const List<Map<String, dynamic>> _bukuPendidikan = [
    {
      'judul': 'Pemrograman Mobile Modern dengan Flutter',
      'penulis': 'Tim Dosen Informatika Telkom',
      'penerbit': 'Telkom University Press (IKAPI)',
      'harga': 'Rp 75.000',
      'kategori': 'Pendidikan',
      'rating': '5.0',
      'sinopsis':
          'Panduan komprehensif pengembangan aplikasi mobile multiplatform dari arsitektur dasar, navigasi tingkat lanjut, state management provider, hingga deployment production.',
    },
    {
      'judul': 'Dasar-Dasar Rekayasa Perangkat Lunak Cerdas',
      'penulis': 'Dr. Ir. Hendra Gunawan, M.T.',
      'penerbit': 'Informatika ITB Bandung (IKAPI)',
      'harga': 'Rp 88.000',
      'kategori': 'Pendidikan',
      'rating': '4.8',
      'sinopsis':
          'Buku referensi standar perguruan tinggi mengenai siklus hidup pengembangan perangkat lunak, metodologi agile, dan penerapan kecerdasan buatan pada industri.',
    },
    {
      'judul': 'Kalkulus Terapan untuk Sains Data',
      'penulis': 'Prof. Dr. Suryana',
      'penerbit': 'Penerbit ITB (IKAPI)',
      'harga': 'Rp 65.000',
      'kategori': 'Pendidikan',
      'rating': '4.6',
      'sinopsis':
          'Konsep kalkulus diferensial dan integral yang diterapkan langsung pada optimasi algoritma pembelajaran mesin dan representasi vektor data.',
    },
  ];

  static const List<Map<String, dynamic>> _bukuBudaya = [
    {
      'judul': 'Tatakrama Basa & Kearifan Ki Sunda',
      'penulis': 'Budi Rahayu Tamsyah',
      'penerbit': 'Geger Sunten (IKAPI)',
      'harga': 'Rp 40.000',
      'kategori': 'Budaya Sunda',
      'rating': '4.9',
      'sinopsis':
          'Kajian mendalam mengenai undak-usuk basa Sunda, falsafah silih asih silih asah silih asuh, serta pelestarian warisan peradaban masyarakat Tatar Sunda.',
    },
    {
      'judul': 'Arsitektur Vernakular Kampung Naga',
      'penulis': 'Nining Sumarni, M.Ds.',
      'penerbit': 'Kiblat Buku Utama (IKAPI)',
      'harga': 'Rp 58.000',
      'kategori': 'Budaya Sunda',
      'rating': '4.8',
      'sinopsis':
          'Analisis tata ruang tradisional, kearifan mitigasi bencana alam, dan filosofi keselarasan bangunan bambu dengan ekosistem perbukitan Tasikmalaya.',
    },
    {
      'judul': 'Pantun Sunda & Naskah Kuno Pajajaran',
      'penulis': 'Dadan Wildan',
      'penerbit': 'Pustaka Jaya Bandung (IKAPI)',
      'harga': 'Rp 62.000',
      'kategori': 'Budaya Sunda',
      'rating': '4.7',
      'sinopsis':
          'Transkripsi dan telaah filologis terhadap carita pantun buhun serta naskah lontar abad ke-16 yang merekam sejarah keemasan kerajaan Pajajaran.',
    },
  ];
}
