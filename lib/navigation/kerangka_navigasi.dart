import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/keranjang_buku_model.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_katalog.dart';
import '../pages/halaman_koleksi_baca.dart';
import 'app_routes.dart';

const Color _primaryColor = Color(0xFF0F7EAD);
const Color _accentColor = Color(0xFF1BABE2);

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksAktif = 0;
  bool _paksaRail = false;

  void _gantiHalaman(int indeks) {
    setState(() {
      _indeksAktif = indeks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> halamanList = [
      HalamanBeranda(onGantiTab: _gantiHalaman),
      const HalamanKatalog(),
      const HalamanKoleksiBaca(),
    ];

    final List<String> judulHalaman = [
      'LiteraIKAPI - Beranda',
      'Katalog E-Book IKAPI',
      'Koleksi & Keranjang E-Book',
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool tampilkanRail = constraints.maxWidth >= 600 || _paksaRail;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: Text(
              judulHalaman[_indeksAktif],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            backgroundColor: _primaryColor,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: Icon(_paksaRail ? Icons.smartphone_rounded : Icons.view_sidebar_rounded),
                tooltip: _paksaRail ? 'Kembali ke NavigationBar Bawah' : 'Tampilkan NavigationRail di Kiri',
                onPressed: () {
                  setState(() {
                    _paksaRail = !_paksaRail;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _paksaRail
                            ? 'Mode NavigationRail sisi kiri diaktifkan!'
                            : 'Mode NavigationBar bilah bawah diaktifkan!',
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const _BadgeIkonKeranjang(icon: Icons.shopping_bag_outlined, color: Colors.white),
                tooltip: 'Buka Keranjang Belanja',
                onPressed: () => _gantiHalaman(2),
              ),
              IconButton(
                icon: const Icon(Icons.business_center_rounded),
                tooltip: 'Portal Penerbit & Royalti',
                onPressed: () => Navigator.pushNamed(context, AppRoutes.penerbit),
              ),
            ],
          ),
          drawer: _buildNavigationDrawer(context),
          body: Row(
            children: [
              if (tampilkanRail) ...[
                NavigationRail(
                  selectedIndex: _indeksAktif,
                  onDestinationSelected: _gantiHalaman,
                  labelType: NavigationRailLabelType.all,
                  backgroundColor: Colors.white,
                  indicatorColor: _primaryColor.withValues(alpha: 0.15),
                  selectedIconTheme: const IconThemeData(color: _primaryColor),
                  selectedLabelTextStyle: const TextStyle(
                    color: _primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  unselectedLabelTextStyle: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [_primaryColor, _accentColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 24),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'IKAPI',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _primaryColor),
                        ),
                      ],
                    ),
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded),
                      label: Text('Beranda'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.explore_outlined),
                      selectedIcon: Icon(Icons.explore_rounded),
                      label: Text('Katalog'),
                    ),
                    NavigationRailDestination(
                      icon: _BadgeIkonKeranjang(icon: Icons.shopping_bag_outlined),
                      selectedIcon: _BadgeIkonKeranjang(icon: Icons.shopping_bag_rounded, color: _primaryColor),
                      label: Text('Keranjang'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1, color: Color(0xFFE2E8F0)),
              ],
              Expanded(child: halamanList[_indeksAktif]),
            ],
          ),
          bottomNavigationBar: tampilkanRail
              ? null
              : NavigationBar(
                  selectedIndex: _indeksAktif,
                  onDestinationSelected: _gantiHalaman,
                  indicatorColor: _primaryColor.withValues(alpha: 0.15),
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded, color: _primaryColor),
                      label: 'Beranda',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.explore_outlined),
                      selectedIcon: Icon(Icons.explore_rounded, color: _primaryColor),
                      label: 'Katalog',
                    ),
                    NavigationDestination(
                      icon: _BadgeIkonKeranjang(icon: Icons.shopping_bag_outlined),
                      selectedIcon: _BadgeIkonKeranjang(icon: Icons.shopping_bag_rounded, color: _primaryColor),
                      label: 'Keranjang',
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildNavigationDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_primaryColor, _accentColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.auto_stories_rounded, color: _primaryColor, size: 30),
                ),
                const SizedBox(height: 10),
                const Text(
                  'LiteraIKAPI Jabar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Marketplace & Digital Publishing IKAPI',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_rounded, color: _primaryColor),
            title: const Text('Beranda'),
            selected: _indeksAktif == 0,
            onTap: () {
              Navigator.pop(context);
              _gantiHalaman(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.explore_rounded, color: _primaryColor),
            title: const Text('Katalog E-Book'),
            selected: _indeksAktif == 1,
            onTap: () {
              Navigator.pop(context);
              _gantiHalaman(1);
            },
          ),
          ListTile(
            leading: const _BadgeIkonKeranjang(icon: Icons.shopping_bag_rounded, color: _primaryColor),
            title: const Text('Keranjang & Koleksi'),
            selected: _indeksAktif == 2,
            onTap: () {
              Navigator.pop(context);
              _gantiHalaman(2);
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'FITUR PRAKTIKUM 4 (INTERAKTIF)',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black45),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.app_registration_rounded, color: _primaryColor),
            title: const Text('Kurasi Naskah Baru'),
            subtitle: const Text('Form registrasi & gesture kurasi', style: TextStyle(fontSize: 11)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.formNaskah);
            },
          ),
          ListTile(
            leading: const Icon(Icons.map_rounded, color: _primaryColor),
            title: const Text('Peta Jaringan IKAPI'),
            subtitle: const Text('Lokasi sekretariat & galeri Bandung', style: TextStyle(fontSize: 11)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.petaIKAPI);
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart_rounded, color: _primaryColor),
            title: const Text('Statistik Royalti'),
            subtitle: const Text('Grafik batang fl_chart data penjualan', style: TextStyle(fontSize: 11)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.statistikRoyalti);
            },
          ),
          ListTile(
            leading: const Icon(Icons.forum_rounded, color: _primaryColor),
            title: const Text('Tanya Redaksi IKAPI'),
            subtitle: const Text('Konsultasi daring kurator penerbitan', style: TextStyle(fontSize: 11)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.tanyaRedaksi);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.business_center_rounded, color: _primaryColor),
            title: const Text('Portal Penerbit & Royalti'),
            subtitle: const Text('Khusus anggota IKAPI Jabar', style: TextStyle(fontSize: 11)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.penerbit);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded, color: _primaryColor),
            title: const Text('Tentang LiteraIKAPI'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.tentang);
            },
          ),
        ],
      ),
    );
  }
}

// Widget Badge efisien menggunakan context.select agar hanya badge yang di-rebuild
class _BadgeIkonKeranjang extends StatelessWidget {
  final IconData icon;
  final Color? color;

  const _BadgeIkonKeranjang({
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final total = context.select<KeranjangBukuModel, int>((m) => m.totalItem);
    return Badge(
      label: Text('$total', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      isLabelVisible: total > 0,
      backgroundColor: Colors.amber.shade800,
      textColor: Colors.white,
      child: Icon(icon, color: color),
    );
  }
}
