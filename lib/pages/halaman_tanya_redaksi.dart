import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pesan_redaksi_model.dart';

const Color _primaryColor = Color(0xFF0F7EAD);
const Color _accentColor = Color(0xFF1BABE2);

class HalamanTanyaRedaksi extends StatefulWidget {
  const HalamanTanyaRedaksi({super.key});

  @override
  State<HalamanTanyaRedaksi> createState() => _HalamanTanyaRedaksiState();
}

class _HalamanTanyaRedaksiState extends State<HalamanTanyaRedaksi> {
  final TextEditingController _pesanController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _pesanController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _kirimPesan() {
    final teks = _pesanController.text;
    if (teks.trim().isEmpty) return;

    context.read<PesanRedaksiModel>().kirimPesanPenulis(teks);
    _pesanController.clear();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tanya Redaksi IKAPI',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(
              'Dewan Kurator & Layanan Penerbitan Jabar',
              style: TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ],
        ),
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Banner Status Redaksi
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFFF1F5F9),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Layanan Kurasi Online Aktif (Balasan otomatis disimulasikan)',
                  style: TextStyle(fontSize: 11.5, color: Colors.black54),
                ),
              ],
            ),
          ),

          // Daftar Pesan
          Expanded(
            child: Consumer<PesanRedaksiModel>(
              builder: (context, chatModel, child) {
                final pesanList = chatModel.daftarPesan;

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: pesanList.length,
                  itemBuilder: (context, index) {
                    final pesan = pesanList[index];
                    final isPenulis = pesan.isPenulis;

                    return Align(
                      alignment: isPenulis ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.78,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: isPenulis ? _primaryColor : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            topRight: const Radius.circular(12),
                            bottomLeft: Radius.circular(isPenulis ? 12 : 2),
                            bottomRight: Radius.circular(isPenulis ? 2 : 12),
                          ),
                          border: isPenulis ? null : Border.all(color: Colors.grey.shade300),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 1)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: isPenulis ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(
                              pesan.namaPengirim,
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: isPenulis ? _accentColor.withValues(alpha: 0.9) : _primaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              pesan.teks,
                              style: TextStyle(
                                fontSize: 13,
                                color: isPenulis ? Colors.white : Colors.black87,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              pesan.waktu,
                              style: TextStyle(
                                fontSize: 9.5,
                                color: isPenulis ? Colors.white60 : Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Input Bar Pesan
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _pesanController,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _kirimPesan(),
                      decoration: InputDecoration(
                        hintText: 'Tulis pertanyaan atau konsultasi redaksi...',
                        hintStyle: const TextStyle(fontSize: 13),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: _primaryColor,
                    radius: 22,
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                      onPressed: _kirimPesan,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
