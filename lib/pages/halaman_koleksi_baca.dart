import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/keranjang_buku_model.dart';
import '../models/favorit_buku_model.dart';

const Color _primaryColor = Color(0xFF0F7EAD);

class HalamanKoleksiBaca extends StatefulWidget {
  final bool isStandalone;

  const HalamanKoleksiBaca({super.key, this.isStandalone = false});

  @override
  State<HalamanKoleksiBaca> createState() => _HalamanKoleksiBacaState();
}

class _HalamanKoleksiBacaState extends State<HalamanKoleksiBaca> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: _primaryColor,
            unselectedLabelColor: const Color(0xFF64748B),
            indicatorColor: _primaryColor,
            indicatorWeight: 3,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            tabs: const [
              Tab(icon: Icon(Icons.shopping_bag_outlined), text: 'Keranjang'),
              Tab(icon: Icon(Icons.favorite_outline_rounded), text: 'Wishlist'),
              Tab(icon: Icon(Icons.menu_book_rounded), text: 'Perpustakaan'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTabKeranjang(context),
              _buildTabWishlist(context),
              _buildTabPerpustakaan(context),
            ],
          ),
        ),
      ],
    );

    if (widget.isStandalone) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: const Text('Koleksi & Keranjang E-Book'),
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
        ),
        body: content,
      );
    }

    return content;
  }

  // TAB 1: KERANJANG BELANJA via Consumer<KeranjangBukuModel>
  Widget _buildTabKeranjang(BuildContext context) {
    return Consumer<KeranjangBukuModel>(
      builder: (context, keranjang, child) {
        if (keranjang.totalItem == 0) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_shopping_cart_outlined, size: 70, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  const Text(
                    'Keranjang Belanja Masih Kosong',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pilih e-book legal berkualitas dari penerbit anggota IKAPI Jawa Barat di tab Katalog.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2FE),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFBAE6FD)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded, color: _primaryColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Terdapat ${keranjang.totalItem} item di keranjang belanja. Transaksi langsung disalurkan ke royalti penerbit.',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF0369A1)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...keranjang.daftarItem.map((buku) {
              final judul = buku['judul'] ?? '';
              final harga = buku['harga'] ?? '';
              final penerbit = buku['penerbit'] ?? '';

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _primaryColor.withValues(alpha: 0.15),
                    child: const Icon(Icons.book_rounded, color: _primaryColor),
                  ),
                  title: Text(judul, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: Text('$penerbit • $harga', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                    tooltip: 'Hapus dari Keranjang',
                    onPressed: () {
                      context.read<KeranjangBukuModel>().hapusBuku(judul);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('E-Book "$judul" dihapus dari keranjang.'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 1.5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Buku', style: TextStyle(color: Color(0xFF64748B))),
                        Text('${keranjang.totalItem} E-Book', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Pembayaran', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        Text(
                          keranjang.totalHargaFormat,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final totalBayar = keranjang.totalHargaFormat;
                          keranjang.kosongkan();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Transaksi $totalBayar berhasil diselesaikan via Midtrans!'),
                              backgroundColor: _primaryColor,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.payments_rounded),
                        label: const Text('Bayar Sekarang via Midtrans'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // TAB 2: WISHLIST via Consumer<FavoritBukuModel>
  Widget _buildTabWishlist(BuildContext context) {
    return Consumer<FavoritBukuModel>(
      builder: (context, favorit, child) {
        if (favorit.totalFavorit == 0) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border_rounded, size: 70, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  const Text(
                    'Wishlist E-Book Kosong',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Simpan karya favorit Anda dengan menekan ikon hati di katalog buku.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.star_rounded, color: Colors.amber.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Tersimpan ${favorit.totalFavorit} karya pilihan Anda di Wishlist IKAPI.',
                      style: TextStyle(fontSize: 12, color: Colors.amber.shade900, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...favorit.daftarFavorit.map((buku) {
              final judul = buku['judul'] ?? '';
              final harga = buku['harga'] ?? '';
              final penerbit = buku['penerbit'] ?? '';

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFFFEBEE),
                    child: Icon(Icons.favorite_rounded, color: Colors.redAccent),
                  ),
                  title: Text(judul, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: Text('$penerbit • $harga', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart_rounded, color: _primaryColor),
                        tooltip: 'Pindahkan ke Keranjang',
                        onPressed: () {
                          context.read<KeranjangBukuModel>().tambahBuku(buku);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('E-Book "$judul" dimasukkan ke keranjang!'),
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: _primaryColor,
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded, color: Colors.grey),
                        tooltip: 'Hapus dari Wishlist',
                        onPressed: () {
                          context.read<FavoritBukuModel>().hapusFavorit(judul);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  // TAB 3: PERPUSTAKAAN SAYA (Buku yang telah dibeli)
  Widget _buildTabPerpustakaan(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
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
              Icon(Icons.cloud_done_rounded, color: _primaryColor),
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
          _primaryColor,
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
          _primaryColor,
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
  }

  Widget _buildKoleksiCard(
    BuildContext context,
    String judul,
    String penulis,
    String penerbit,
    String progresText,
    double progress,
    Color progressColor,
  ) {
    return Card(
      elevation: 1.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 68,
                  decoration: BoxDecoration(
                    color: _primaryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _primaryColor.withValues(alpha: 0.3)),
                  ),
                  child: const Center(
                    child: Icon(Icons.menu_book_rounded, color: _primaryColor, size: 28),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        judul,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                      ),
                      const SizedBox(height: 3),
                      Text('Penulis: $penulis', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                      const SizedBox(height: 2),
                      Text('Penerbit: $penerbit', style: const TextStyle(fontSize: 11, color: _primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade200,
              color: progressColor,
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(progresText, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
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
