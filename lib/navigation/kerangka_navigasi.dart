import 'package:flutter/material.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_katalog.dart';
import '../pages/halaman_koleksi_baca.dart';
import 'app_routes.dart';

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
    const primaryColor = Color(0xFF0F7EAD);
    const accentColor = Color(0xFF1BABE2);

    final List<Widget> halamanList = [
      HalamanBeranda(onGantiTab: _gantiHalaman),
      const HalamanKatalog(),
      const HalamanKoleksiBaca(),
    ];

    final List<String> judulHalaman = [
      'LiteraIKAPI - Beranda',
      'Katalog E-Book IKAPI',
      'Koleksi E-Book Saya',
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
            backgroundColor: primaryColor,
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
                icon: const Icon(Icons.business_center_rounded),
                tooltip: 'Portal Penerbit & Royalti',
                onPressed: () => Navigator.pushNamed(context, AppRoutes.penerbit),
              ),
            ],
          ),
          drawer: _buildNavigationDrawer(context, primaryColor, accentColor),
          body: tampilkanRail
              ? Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _indeksAktif,
                      onDestinationSelected: _gantiHalaman,
                      labelType: NavigationRailLabelType.all,
                      backgroundColor: Colors.white,
                      indicatorColor: primaryColor.withValues(alpha: 0.15),
                      selectedIconTheme: const IconThemeData(color: primaryColor),
                      selectedLabelTextStyle: const TextStyle(
                        color: primaryColor,
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
                                  colors: [primaryColor, accentColor],
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
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: primaryColor),
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
                          icon: Icon(Icons.auto_stories_outlined),
                          selectedIcon: Icon(Icons.auto_stories_rounded),
                          label: Text('Koleksi'),
                        ),
                      ],
                    ),
                    const VerticalDivider(thickness: 1, width: 1, color: Color(0xFFE2E8F0)),
                    Expanded(child: halamanList[_indeksAktif]),
                  ],
                )
              : halamanList[_indeksAktif],
          bottomNavigationBar: tampilkanRail
              ? null
              : NavigationBar(
                  selectedIndex: _indeksAktif,
                  onDestinationSelected: _gantiHalaman,
                  indicatorColor: primaryColor.withValues(alpha: 0.15),
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded, color: primaryColor),
                      label: 'Beranda',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.explore_outlined),
                      selectedIcon: Icon(Icons.explore_rounded, color: primaryColor),
                      label: 'Katalog',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.auto_stories_outlined),
                      selectedIcon: Icon(Icons.auto_stories_rounded, color: primaryColor),
                      label: 'Koleksi Saya',
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildNavigationDrawer(BuildContext context, Color primaryColor, Color accentColor) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, accentColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_rounded,
                size: 45,
                color: primaryColor,
              ),
            ),
            accountName: const Text(
              'Falih Afnan Fauzi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            accountEmail: const Text(
              'Penerbit Anggota IKAPI Jabar (707012400017)',
              style: TextStyle(fontSize: 12),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_rounded, color: primaryColor),
            title: const Text('Beranda LiteraIKAPI'),
            selected: _indeksAktif == 0,
            onTap: () {
              Navigator.pop(context);
              _gantiHalaman(0);
            },
          ),
          ListTile(
            leading: Icon(Icons.explore_rounded, color: primaryColor),
            title: const Text('Katalog E-Book'),
            selected: _indeksAktif == 1,
            onTap: () {
              Navigator.pop(context);
              _gantiHalaman(1);
            },
          ),
          ListTile(
            leading: Icon(Icons.auto_stories_rounded, color: primaryColor),
            title: const Text('Koleksi Baca Saya'),
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
              'Portal & Layanan Pendukung',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          ListTile(
            leading: Icon(Icons.business_center_rounded, color: primaryColor),
            title: const Text('Portal Royalti Penerbit'),
            subtitle: const Text('Kelola karya & pencairan saldo', style: TextStyle(fontSize: 11)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.penerbit);
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline_rounded, color: primaryColor),
            title: const Text('Tentang LiteraIKAPI'),
            subtitle: const Text('Visi misi & solusi platform', style: TextStyle(fontSize: 11)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.tentang);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.bug_report_rounded, color: Colors.redAccent),
            title: const Text('Uji Rute Galat 404'),
            subtitle: const Text('Simulasi onUnknownRoute', style: TextStyle(fontSize: 11)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/rute_salah_uji_404');
            },
          ),
        ],
      ),
    );
  }
}
