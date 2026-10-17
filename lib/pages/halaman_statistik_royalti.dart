import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../models/kurasi_naskah_model.dart';

const Color _primaryColor = Color(0xFF0F7EAD);
const Color _accentColor = Color(0xFF1BABE2);

class HalamanStatistikRoyalti extends StatelessWidget {
  const HalamanStatistikRoyalti({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistik & Distribusi Royalti',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Consumer<KurasiNaskahModel>(
        builder: (context, kurasiModel, child) {
          final countPendidikan = kurasiModel.jumlahByKategori('Pendidikan');
          final countBudaya = kurasiModel.jumlahByKategori('Budaya');
          final countSastra = kurasiModel.jumlahByKategori('Sastra');

          // Nilai minimal 1 agar bar tetap terlihat proporsional
          final double valPendidikan = (countPendidikan + 3).toDouble();
          final double valBudaya = (countBudaya + 2).toDouble();
          final double valSastra = (countSastra + 2).toDouble();

          final double maxVal = [valPendidikan, valBudaya, valSastra].reduce((a, b) => a > b ? a : b) + 2;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kartu Ringkasan Metrik
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Royalti Terdistribusi Penulis (2026)',
                        style: TextStyle(fontSize: 12.5, color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Rp 42.850.000',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      const Divider(color: Colors.white24, height: 1),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _metrikItem('Total Naskah', '${kurasiModel.totalNaskah + 8} Karya'),
                          _metrikItem('Naskah Disetujui', '${kurasiModel.totalDisetujui + 6} Terbit'),
                          _metrikItem('Skema Royalti', '70% : 30%'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Card Grafik Batang fl_chart
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.bar_chart_rounded, color: _primaryColor),
                            SizedBox(width: 8),
                            Text(
                              'Distribusi Naskah & Volume Royalti',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Visualisasi jumlah karya aktif dan volume kurasi per klaster literasi IKAPI Jabar.',
                          style: TextStyle(fontSize: 11.5, color: Colors.black54),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 220,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: maxVal,
                              barTouchData: BarTouchData(
                                enabled: true,
                                touchTooltipData: BarTouchTooltipData(
                                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                    String kategori = '';
                                    switch (group.x) {
                                      case 0:
                                        kategori = 'Pendidikan & Riset';
                                        break;
                                      case 1:
                                        kategori = 'Budaya Pasundan';
                                        break;
                                      case 2:
                                        kategori = 'Sastra & Fiksi';
                                        break;
                                    }
                                    return BarTooltipItem(
                                      '$kategori\n${rod.toY.toInt()} Judul Aktif',
                                      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                                    );
                                  },
                                ),
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      String text = '';
                                      switch (value.toInt()) {
                                        case 0:
                                          text = 'Pendidikan';
                                          break;
                                        case 1:
                                          text = 'Budaya';
                                          break;
                                        case 2:
                                          text = 'Sastra';
                                          break;
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          text,
                                          style: const TextStyle(
                                            color: _primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11.5,
                                          ),
                                        ),
                                      );
                                    },
                                    reservedSize: 28,
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 28,
                                    getTitlesWidget: (value, meta) {
                                      if (value % 2 == 0) {
                                        return Text(
                                          value.toInt().toString(),
                                          style: const TextStyle(fontSize: 10, color: Colors.black54),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ),
                                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                horizontalInterval: 2,
                                getDrawingHorizontalLine: (value) => FlLine(
                                  color: Colors.grey.shade200,
                                  strokeWidth: 1,
                                ),
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey.shade300),
                                  left: BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                              barGroups: [
                                BarChartGroupData(
                                  x: 0,
                                  barRods: [
                                    BarChartRodData(
                                      toY: valPendidikan,
                                      color: _primaryColor,
                                      width: 28,
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                                    ),
                                  ],
                                ),
                                BarChartGroupData(
                                  x: 1,
                                  barRods: [
                                    BarChartRodData(
                                      toY: valBudaya,
                                      color: _accentColor,
                                      width: 28,
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                                    ),
                                  ],
                                ),
                                BarChartGroupData(
                                  x: 2,
                                  barRods: [
                                    BarChartRodData(
                                      toY: valSastra,
                                      color: const Color(0xFF0369A1),
                                      width: 28,
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Rincian Klaster
                const Text(
                  'Rincian Klaster & Alokasi Royalti',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 8),

                _klasterCard(
                  'Klaster Pendidikan & Riset Ilmiah',
                  'Total ${valPendidikan.toInt()} Judul • Estimasi Royalti Rp 21.400.000',
                  'Monograf akademik, buku ajar perguruan tinggi Bandung Raya.',
                  _primaryColor,
                ),
                _klasterCard(
                  'Klaster Seni & Budaya Parahyangan',
                  'Total ${valBudaya.toInt()} Judul • Estimasi Royalti Rp 12.650.000',
                  'Digitalisasi naskah lontar Sunda, carita pantun, cagar budaya.',
                  _accentColor,
                ),
                _klasterCard(
                  'Klaster Sastra, Novel & Puisi Modern',
                  'Total ${valSastra.toInt()} Judul • Estimasi Royalti Rp 8.800.000',
                  'Karya fiksi kontemporer, antologi sajak priangan, novelet.',
                  const Color(0xFF0369A1),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget _metrikItem(String label, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.white70)),
        const SizedBox(height: 2),
        Text(val, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  Widget _klasterCard(String title, String subtitle, String desc, Color badgeColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 10,
              height: 48,
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: badgeColor)),
                  const SizedBox(height: 4),
                  Text(desc, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
