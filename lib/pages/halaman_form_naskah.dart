// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/kurasi_naskah_model.dart';

const Color _primaryColor = Color(0xFF0F7EAD);
const Color _accentColor = Color(0xFF1BABE2);

class HalamanFormNaskah extends StatefulWidget {
  const HalamanFormNaskah({super.key});

  @override
  State<HalamanFormNaskah> createState() => _HalamanFormNaskahState();
}

class _HalamanFormNaskahState extends State<HalamanFormNaskah> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _judulController = TextEditingController(text: 'Arsitektur Kota Cerdas Pasundan');
  final TextEditingController _penulisController = TextEditingController(text: 'Falih Afnan Fauzi');
  final TextEditingController _emailController = TextEditingController(text: 'falih@telkomuniversity.ac.id');
  final TextEditingController _halamanController = TextEditingController(text: '245');
  final TextEditingController _sinopsisController = TextEditingController(text: 'Kajian implementasi IoT dan tata kelola digital berbasis kearifan lokal.');

  String _genreTerpilih = 'Budaya Pasundan';
  bool _setujuDrm = true;
  bool _setujuRoyalti = true;
  bool _sedangMemuat = false;

  @override
  void dispose() {
    _judulController.dispose();
    _penulisController.dispose();
    _emailController.dispose();
    _halamanController.dispose();
    _sinopsisController.dispose();
    super.dispose();
  }

  void _kirimFormulir() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_setujuDrm || !_setujuRoyalti) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap centang persetujuan LiteraDRM™ dan skema royalti!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      _sedangMemuat = true;
    });

    // Simulasi enkripsi DRM dan registrasi naskah (1.5 detik)
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    final naskahBaru = ItemNaskah(
      id: 'NSK-00${DateTime.now().millisecond}',
      judul: _judulController.text.trim(),
      penulis: _penulisController.text.trim(),
      email: _emailController.text.trim(),
      kategori: _genreTerpilih,
      halaman: int.tryParse(_halamanController.text.trim()) ?? 100,
      sinopsis: _sinopsisController.text.trim().isEmpty
          ? 'Naskah literasi digital Jawa Barat terkurasi.'
          : _sinopsisController.text.trim(),
      setujuDrm: _setujuDrm,
      setujuRoyalti: _setujuRoyalti,
      status: 'Menunggu Kurasi',
      tanggalPengajuan: '14/10/2026',
    );

    context.read<KurasiNaskahModel>().tambahNaskah(naskahBaru);

    setState(() {
      _sedangMemuat = false;
      _judulController.clear();
      _penulisController.clear();
      _emailController.clear();
      _halamanController.clear();
      _sinopsisController.clear();
      _genreTerpilih = 'Pendidikan & Riset';
      _setujuDrm = false;
      _setujuRoyalti = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Naskah "${naskahBaru.judul}" berhasil diajukan ke Dewan Kurator!'),
        backgroundColor: Colors.teal.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _tampilkanDetailNaskah(ItemNaskah naskah) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.menu_book_rounded, color: _primaryColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                naskah.judul,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _detailRow('ID Registrasi', naskah.id),
              _detailRow('Penulis', naskah.penulis),
              _detailRow('Email Penulis', naskah.email),
              _detailRow('Kategori / Genre', naskah.kategori),
              _detailRow('Estimasi Halaman', '${naskah.halaman} hlm'),
              _detailRow('Status Kurasi', naskah.status),
              _detailRow('Tanggal Daftar', naskah.tanggalPengajuan),
              _detailRow('Enkripsi DRM', naskah.setujuDrm ? 'Aktif (AES-256)' : 'Nonaktif'),
              _detailRow('Skema Royalti', naskah.setujuRoyalti ? '70% Penulis : 30% IKAPI' : 'Belum Disetujui'),
              const Divider(height: 20),
              const Text(
                'Sinopsis Naskah:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                naskah.sinopsis,
                style: const TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black54),
            ),
          ),
          const Text(': ', style: TextStyle(fontSize: 12, color: Colors.black54)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  void _bukaMenuAksiNaskah(ItemNaskah naskah) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Kelola Naskah: ${naskah.judul}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.check_circle_outline, color: Colors.green),
                title: const Text('Setujui Naskah & Masuk Antrean Terbit'),
                onTap: () {
                  context.read<KurasiNaskahModel>().ubahStatus(naskah.id, 'Disetujui Redaksi');
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Status "${naskah.judul}" diubah menjadi Disetujui Redaksi!')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.menu_book, color: _primaryColor),
                title: const Text('Terbitkan Langsung ke Katalog'),
                onTap: () {
                  context.read<KurasiNaskahModel>().ubahStatus(naskah.id, 'Terbit Katalog');
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Status "${naskah.judul}" diubah menjadi Terbit Katalog!')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text('Hapus Pengajuan Naskah'),
                onTap: () {
                  context.read<KurasiNaskahModel>().hapusNaskah(naskah.id);
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Naskah "${naskah.judul}" telah dihapus.')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kurasi & Pendaftaran Naskah',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Info
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _accentColor.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.app_registration_rounded, color: _primaryColor, size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Formulir Pendaftaran Karya Digital IKAPI Jabar. Lengkapi formulir untuk proses telaah redaksi, enkripsi LiteraDRM™, dan distribusi royalti.',
                      style: TextStyle(fontSize: 12.5, color: Color(0xFF1E293B), height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Card Formulir
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Informasi Karya & Penulis',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: _primaryColor),
                      ),
                      const SizedBox(height: 12),

                      // Judul Naskah
                      TextFormField(
                        controller: _judulController,
                        decoration: const InputDecoration(
                          labelText: 'Judul Naskah E-Book *',
                          hintText: 'Contoh: Budaya Literasi Pasundan Digital',
                          prefixIcon: Icon(Icons.book_outlined),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Judul naskah wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      // Nama Penulis
                      TextFormField(
                        controller: _penulisController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Lengkap Penulis *',
                          hintText: 'Contoh: Falih Afnan Fauzi',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama penulis wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      // Email Penulis
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Alamat Email Penulis *',
                          hintText: 'email@instansi.ac.id',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Alamat email wajib diisi';
                          }
                          if (!value.contains('@')) {
                            return 'Email harus memuat karakter @ yang valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      // Estimasi Halaman
                      TextFormField(
                        controller: _halamanController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Estimasi Jumlah Halaman *',
                          hintText: 'Contoh: 180',
                          prefixIcon: Icon(Icons.format_list_numbered_rounded),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Estimasi halaman wajib diisi';
                          }
                          final parsed = int.tryParse(value.trim());
                          if (parsed == null || parsed <= 0) {
                            return 'Masukkan angka halaman yang valid (> 0)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      // Sinopsis Ringkas
                      TextFormField(
                        controller: _sinopsisController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Sinopsis Singkat Karya',
                          hintText: 'Tuliskan deskripsi ringkas tentang topik buku...',
                          prefixIcon: Icon(Icons.description_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Kategori Genre (RadioListTile)
                      const Text(
                        'Pilihan Genre / Klaster Literasi:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      RadioListTile<String>(
                        title: const Text('Pendidikan & Riset', style: TextStyle(fontSize: 13.5)),
                        value: 'Pendidikan & Riset',
                        groupValue: _genreTerpilih,
                        activeColor: _primaryColor,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (val) {
                          if (val != null) setState(() => _genreTerpilih = val);
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Budaya Pasundan & Kearifan Lokal', style: TextStyle(fontSize: 13.5)),
                        value: 'Budaya Pasundan',
                        groupValue: _genreTerpilih,
                        activeColor: _primaryColor,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (val) {
                          if (val != null) setState(() => _genreTerpilih = val);
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Sastra, Fiksi & Puisi', style: TextStyle(fontSize: 13.5)),
                        value: 'Sastra & Fiksi',
                        groupValue: _genreTerpilih,
                        activeColor: _primaryColor,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (val) {
                          if (val != null) setState(() => _genreTerpilih = val);
                        },
                      ),

                      const SizedBox(height: 12),

                      // Checkbox Persetujuan DRM
                      CheckboxListTile(
                        value: _setujuDrm,
                        activeColor: _primaryColor,
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Persetujuan Enkripsi LiteraDRM™',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        subtitle: const Text(
                          'Saya menyetujui penerapan proteksi hak cipta anti-pembajakan AES-256 oleh IKAPI Jawa Barat.',
                          style: TextStyle(fontSize: 11.5),
                        ),
                        onChanged: (val) => setState(() => _setujuDrm = val ?? false),
                      ),

                      // Checkbox Skema Royalti
                      CheckboxListTile(
                        value: _setujuRoyalti,
                        activeColor: _primaryColor,
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Persetujuan Skema Royalti 70:30',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        subtitle: const Text(
                          'Saya sepakat dengan pembagian royalti transparan 70% penulis dan 30% operasional platform penerbitan.',
                          style: TextStyle(fontSize: 11.5),
                        ),
                        onChanged: (val) => setState(() => _setujuRoyalti = val ?? false),
                      ),

                      const SizedBox(height: 16),

                      // Tombol Submit
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _sedangMemuat ? null : _kirimFormulir,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: _sedangMemuat
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.send_rounded, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'Daftarkan Naskah Baru',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Daftar Naskah Terdaftar
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Riwayat Naskah Terdaftar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                ),
                Text(
                  '(Tekan lama untuk ubah status)',
                  style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Consumer<KurasiNaskahModel>(
              builder: (context, kurasiModel, child) {
                final daftar = kurasiModel.daftarNaskah;
                if (daftar.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: Text('Belum ada naskah terdaftar.')),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: daftar.length,
                  itemBuilder: (context, index) {
                    final item = daftar[index];
                    final bool isApproved = item.status == 'Disetujui Redaksi' || item.status == 'Terbit Katalog';

                    return GestureDetector(
                      onTap: () => _tampilkanDetailNaskah(item),
                      onLongPress: () => _bukaMenuAksiNaskah(item),
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        elevation: 0.8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: isApproved ? Colors.teal.shade200 : Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: isApproved ? Colors.teal.shade50 : Colors.blueGrey.shade50,
                                radius: 22,
                                child: Icon(
                                  isApproved ? Icons.verified_rounded : Icons.hourglass_top_rounded,
                                  color: isApproved ? Colors.teal.shade700 : Colors.blueGrey.shade600,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.judul,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${item.penulis} • ${item.kategori}',
                                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: isApproved ? Colors.teal.shade50 : Colors.amber.shade50,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            item.status,
                                            style: TextStyle(
                                              fontSize: 10.5,
                                              fontWeight: FontWeight.bold,
                                              color: isApproved ? Colors.teal.shade800 : Colors.amber.shade900,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${item.halaman} Hal • ${item.tanggalPengajuan}',
                                          style: const TextStyle(fontSize: 11, color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.black38),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
