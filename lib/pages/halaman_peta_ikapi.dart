import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const Color _primaryColor = Color(0xFF0F7EAD);

class HalamanPetaIKAPI extends StatefulWidget {
  const HalamanPetaIKAPI({super.key});

  @override
  State<HalamanPetaIKAPI> createState() => _HalamanPetaIKAPIState();
}

class _HalamanPetaIKAPIState extends State<HalamanPetaIKAPI> {
  GoogleMapController? _mapController;

  static const LatLng _pusatBandung = LatLng(-6.917464, 107.619123);

  final List<Map<String, dynamic>> _lokasiIKAPI = [
    {
      'id': 'ikapi_sekretariat',
      'nama': 'Sekretariat DPD IKAPI Jawa Barat',
      'alamat': 'Jl. Buah Batu No. 161, Turangga, Lengkong, Kota Bandung',
      'posisi': const LatLng(-6.937200, 107.625500),
      'layanan': 'Pendaftaran Anggota, Kurasi ISBN, Konsultasi Penerbitan',
      'jam': '08.00 - 16.00 WIB',
    },
    {
      'id': 'ikapi_braga',
      'nama': 'Galeri Literasi Heritage Braga',
      'alamat': 'Jl. Braga No. 10, Braga, Sumur Bandung, Kota Bandung',
      'posisi': const LatLng(-6.917500, 107.609800),
      'layanan': 'Showroom Buku Cetak & E-Book Corner LiteraDRM',
      'jam': '09.00 - 21.00 WIB',
    },
    {
      'id': 'ikapi_literahub',
      'nama': 'Sentra LiteraHub Gedung Sate',
      'alamat': 'Jl. Diponegoro No. 22, Citarum, Bandung Wetan, Kota Bandung',
      'posisi': const LatLng(-6.902400, 107.618600),
      'layanan': 'Pusat Distribusi Digital & Laboratorium Smart Heritage',
      'jam': '08.30 - 17.00 WIB',
    },
  ];

  late Set<Marker> _markers;
  int _indeksTerpilih = 0;

  @override
  void initState() {
    super.initState();
    _markers = _lokasiIKAPI.map((lokasi) {
      return Marker(
        markerId: MarkerId(lokasi['id']),
        position: lokasi['posisi'] as LatLng,
        infoWindow: InfoWindow(
          title: lokasi['nama'],
          snippet: lokasi['alamat'],
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      );
    }).toSet();
  }

  void _fokusLokasi(int index) {
    setState(() {
      _indeksTerpilih = index;
    });
    final target = _lokasiIKAPI[index]['posisi'] as LatLng;
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: 15.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lokasiAktif = _lokasiIKAPI[_indeksTerpilih];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jaringan Layanan IKAPI Jabar',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Google Map view
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: _pusatBandung,
                    zoom: 12.8,
                  ),
                  markers: _markers,
                  onMapCreated: (controller) => _mapController = controller,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: true,
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.location_on, color: _primaryColor, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Peta Sebaran Sekretariat & Sentra Literasi IKAPI Jawa Barat',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Detail Card Lokasi Terpilih & Selector
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.storefront_rounded, color: _primaryColor, size: 24),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        lokasiAktif['nama'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  lokasiAktif['alamat'],
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded, size: 14, color: Colors.black45),
                    const SizedBox(width: 4),
                    Text(
                      lokasiAktif['jam'],
                      style: const TextStyle(fontSize: 11.5, color: Colors.black54),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Layanan Terverifikasi',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.teal.shade800),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 18),
                const Text(
                  'Pilih Titik Layanan untuk Navigasi Kamera:',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _lokasiIKAPI.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, idx) {
                      final item = _lokasiIKAPI[idx];
                      final isAktif = idx == _indeksTerpilih;
                      return ElevatedButton(
                        onPressed: () => _fokusLokasi(idx),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isAktif ? _primaryColor : const Color(0xFFF1F5F9),
                          foregroundColor: isAktif ? Colors.white : Colors.black87,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isAktif ? _primaryColor : Colors.grey.shade300,
                            ),
                          ),
                        ),
                        child: Text(
                          item['id'] == 'ikapi_sekretariat'
                              ? 'Sekretariat'
                              : item['id'] == 'ikapi_braga'
                                  ? 'Braga Heritage'
                                  : 'Gedung Sate',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isAktif ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
