# LiteraIKAPI - Marketplace & Digital Publishing Platform

**Tugas Besar Pemrograman Perangkat Bergerak Lanjut (PPBL) - Modul II (Soal 2)**

---

### Profil Mahasiswa
- **Nama**: Falih Afnan Fauzi
- **NIM**: 707012400017
- **Kelas**: 48-03
- **Program Studi**: D4 Sistem Informasi Kota Cerdas
- **Fakultas**: Fakultas Ilmu Terapan, Universitas Telkom

---

### 1. Deskripsi & Latar Belakang Aplikasi
Tugas besar ini mengusung tema **E-Commerce & Digital Publishing Platform** dengan nama aplikasi **LiteraIKAPI**, yaitu platform marketplace buku digital (*e-book*) berbasis web/mobile yang dikembangkan untuk menyelesaikan permasalahan tingginya biaya cetak dan logistik buku fisik, terbatasnya jangkauan distribusi penerbit lokal di Jawa Barat, serta maraknya pembajakan dokumen digital melalui penyediaan akses baca terproteksi (*web reader LiteraDRM™*) dan transaksi instan terintegrasi *Midtrans*.

Sistem ini dirancang untuk tiga pihak pengguna utama:
1. **Penerbit Anggota IKAPI Jawa Barat**: Untuk mempublikasikan katalog karya secara mandiri serta memantau saldo royalti penjualan secara transparan.
2. **Pembaca / Masyarakat Umum**: Sebagai konsumen yang dapat membeli dan menikmati *e-book* legal secara praktis, terjangkau, dan aman.
3. **Administrator IKAPI**: Bertugas mengurasi kelayakan konten buku sebelum diterbitkan sekaligus memvalidasi pencairan dana pendapatan penerbit.

---

### 2. Penerapan Identitas Visual (Branding IKAPI)
Warna aplikasi diadaptasi secara langsung dari identitas resmi **Logo IKAPI** (Ikatan Penerbit Indonesia):
- **Warna Utama (Primary Teal Blue)**: `#0F7EAD`
- **Warna Aksen (Vibrant Cyan)**: `#1BABE2`
- **Warna Latar (Clean Canvas)**: `#F8FAFC`

---

### 3. Arsitektur & Komponen Navigasi (Sesuai Modul II Soal 2)
Aplikasi ini mengimplementasikan seluruh kompetensi navigasi Flutter tingkat lanjut:
1. **Named Routes Terpusat (`AppRoutes`)**: Seluruh perpindahan halaman dikelola melalui rute bernama di `lib/navigation/app_routes.dart`.
2. **Navigasi Adaptif (NavigationRail di Sisi Kiri)**: Menggunakan `LayoutBuilder` / `MediaQuery` untuk menampilkan `NavigationRail` di sisi kiri pada layar lebar/tablet/landscape dan `NavigationBar` di bilah bawah pada layar seluler (dilengkapi tombol toggle manual di AppBar).
3. **NavigationDrawer (Menu Balai Pustaka IKAPI)**: Menyediakan menu samping profil akun penerbit, akses cepat modul pendukung, dan navigasi terpadu.
4. **Tab Navigation (3 Kategori E-Book)**: Menggunakan `DefaultTabController`, `TabBar`, dan `TabBarView` untuk mengelompokkan kategori karya:
   - *Fiksi & Sastra*
   - *Pendidikan & Sains*
   - *Budaya Sunda & Jawa Barat*
5. **Passing Data Dua Arah (Push & Pop)**: Mengirimkan argumen dinamis ke `HalamanDetailBuku` dan mengembalikan nilai konfirmasi transaksi pembayaran Midtrans via `Navigator.pop(context, value)` yang ditampilkan melalui `SnackBar`.
6. **BottomAppBar & FloatingActionButton**: Diterapkan pada `HalamanKoleksiBaca` dengan tombol aksi anotasi/catatan baca ter-dock di tengah.
7. **Penanganan Rute Galat 404 (`onUnknownRoute`)**: Mencegah *crash* aplikasi saat memanggil rute tak terdaftar dan mengarahkan pengguna kembali ke beranda.

---

### 4. Struktur Direktori Proyek
```text
lib/
├── main.dart                      # Inisialisasi MaterialApp, tema IKAPI, & rute
├── navigation/
│   ├── app_routes.dart            # Named routes, onGenerateRoute, onUnknownRoute
│   └── kerangka_navigasi.dart     # Adaptive layout (NavigationRail & NavigationBar), Drawer
└── pages/
    ├── halaman_beranda.dart       # Dashboard utama, statistik ekosistem, featured books
    ├── halaman_katalog.dart       # TabBar 3 kategori e-book & list view
    ├── halaman_detail_buku.dart   # Detail e-book penerima argumen & aksi Midtrans
    ├── halaman_penerbit.dart      # Portal penerbit, saldo royalti, & kurasi IKAPI
    ├── halaman_koleksi_baca.dart  # Koleksi pembaca berfasilitas BottomAppBar & FAB
    ├── halaman_tentang.dart       # Profil platform, solusi masalah, & info pengembang
    └── halaman_galat_404.dart     # Penanganan rute tak dikenal (onUnknownRoute)
```

---

### 5. Cara Menjalankan Proyek
1. Buka terminal pada folder proyek:
   ```bash
   cd tubes_literaikapi_707012400017
   ```
2. Ambil pustaka dependensi:
   ```bash
   flutter pub get
   ```
3. Uji analisis kode:
   ```bash
   flutter analyze
   ```
4. Jalankan aplikasi pada perangkat/emulator:
   ```bash
   flutter run
   ```
