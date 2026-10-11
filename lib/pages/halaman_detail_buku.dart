import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/keranjang_buku_model.dart';
import '../models/favorit_buku_model.dart';
import '../navigation/app_routes.dart';

class HalamanDetailBuku extends StatefulWidget {
  final String judul;
  final String penulis;
  final String penerbit;
  final String harga;
  final String kategori;
  final String sinopsis;
  final String rating;

  const HalamanDetailBuku({
    super.key,
    required this.judul,
    required this.penulis,
    required this.penerbit,
    required this.harga,
    required this.kategori,
    required this.sinopsis,
    required this.rating,
  });

  @override
  State<HalamanDetailBuku> createState() => _HalamanDetailBukuState();
}

class _HalamanDetailBukuState extends State<HalamanDetailBuku> {
  // Local state untuk status transaksi pembayaran instan Midtrans
  bool _sedangMemproses = false;

  Map<String, dynamic> _bukuData() {
    return {
      'judul': widget.judul,
      'penulis': widget.penulis,
      'penerbit': widget.penerbit,
      'harga': widget.harga,
      'kategori': widget.kategori,
      'sinopsis': widget.sinopsis,
      'rating': widget.rating,
    };
  }

  Future<void> _prosesTransaksiMidtrans() async {
    setState(() {
      _sedangMemproses = true;
    });

    // Simulasi enkripsi transaksi dan verifikasi token pembayaran Midtrans
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Masukkan ke keranjang/riwayat transaksi
    context.read<KeranjangBukuModel>().tambahBuku(_bukuData());

    Navigator.pop(
      context,
      'Pembelian e-book "${widget.judul}" (${widget.harga}) berhasil diverifikasi via Payment Gateway Midtrans!',
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0F7EAD);
    const accentColor = Color(0xFF1BABE2);

    final bool isFavorit = context.watch<FavoritBukuModel>().apakahFavorit(widget.judul);
    final bool diKeranjang = context.watch<KeranjangBukuModel>().adaDiKeranjang(widget.judul);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Detail E-Book'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              isFavorit ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: isFavorit ? Colors.redAccent : Colors.white,
            ),
            tooltip: isFavorit ? 'Hapus dari Wishlist' : 'Tambah ke Wishlist',
            onPressed: () {
              final model = context.read<FavoritBukuModel>();
              model.toggleFavorit(_bukuData());
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFavorit
                        ? 'E-Book "${widget.judul}" dihapus dari Wishlist.'
                        : 'E-Book "${widget.judul}" ditambahkan ke Wishlist!',
                  ),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            tooltip: 'Keranjang Belanja',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.koleksiBaca),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner kartu buku
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white54, width: 1.5),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.menu_book_rounded,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            widget.kategori.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.judul,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Oleh: ${widget.penulis}',
                          style: const TextStyle(fontSize: 13, color: Colors.white70),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amberAccent, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              widget.rating,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.verified_rounded, color: Colors.lightGreenAccent, size: 16),
                            const SizedBox(width: 4),
                            const Text(
                              'Anggota IKAPI',
                              style: TextStyle(color: Colors.white70, fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Info ringkas penerbit & harga
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 1,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildInfoColumn('Penerbit', widget.penerbit, Icons.business_rounded, primaryColor),
                    Container(height: 40, width: 1, color: Colors.grey.shade300),
                    _buildInfoColumn('Harga Resmi', widget.harga, Icons.payments_rounded, Colors.green.shade700),
                    Container(height: 40, width: 1, color: Colors.grey.shade300),
                    _buildInfoColumn('Proteksi', 'DRM Protected', Icons.security_rounded, primaryColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sinopsis buku
            const Text(
              'Sinopsis & Deskripsi Karya',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                widget.sinopsis,
                style: const TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF334155)),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),

            // Keamanan & Hak Cipta
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2FE),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFBAE6FD)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lock_rounded, color: primaryColor, size: 22),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'E-book ini dilindungi enkripsi LiteraDRM™. Bebas pembajakan dan dapat dibaca langsung melalui Web Reader IKAPI.',
                      style: TextStyle(fontSize: 12, color: Color(0xFF0369A1)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tombol 1: Tambah ke Keranjang
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: diKeranjang
                    ? () {
                        context.read<KeranjangBukuModel>().hapusBuku(widget.judul);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('E-Book "${widget.judul}" dikeluarkan dari keranjang.'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    : () {
                        context.read<KeranjangBukuModel>().tambahBuku(_bukuData());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('E-Book "${widget.judul}" berhasil dimasukkan ke keranjang!'),
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: primaryColor,
                          ),
                        );
                      },
                icon: Icon(diKeranjang ? Icons.remove_shopping_cart_rounded : Icons.add_shopping_cart_rounded),
                label: Text(diKeranjang ? 'Hapus dari Keranjang Belanja' : 'Tambah ke Keranjang Belanja'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: diKeranjang ? Colors.red.shade700 : primaryColor,
                  side: BorderSide(color: diKeranjang ? Colors.red.shade300 : primaryColor, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Tombol 2: Aksi Transaksi Instan Midtrans dengan Local State Loading
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _sedangMemproses ? null : _prosesTransaksiMidtrans,
                icon: _sedangMemproses
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.payments_rounded),
                label: Text(
                  _sedangMemproses
                      ? 'Memproses Transaksi Midtrans...'
                      : 'Beli E-Book Sekarang (${widget.harga}) via Midtrans',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Tombol 3: Pratinjau Bab 1
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pop(
                    context,
                    'Pratinjau Bab 1 "${widget.judul}" telah dibuka pada Web Reader terproteksi.',
                  );
                },
                icon: const Icon(Icons.chrome_reader_mode_rounded),
                label: const Text('Buka Pratinjau Bab 1 (Gratis)'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF64748B),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value, IconData icon, Color iconColor) {
    return Column(
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }
}
