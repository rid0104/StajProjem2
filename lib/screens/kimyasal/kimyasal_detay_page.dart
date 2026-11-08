import 'package:flutter/material.dart';

import '../../models/kimyasal.dart';

class KimyasalDetayPage
    extends StatelessWidget {
  final Kimyasal kimyasal;

  const KimyasalDetayPage({
    super.key,
    required this.kimyasal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kimyasal Detay",
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              "Ad: ${kimyasal.kimyasaladi}",
            ),
            Text(
              "Kategori: ${kimyasal.kategori}",
            ),
            Text(
              "Kod: ${kimyasal.kimyasalkodu}",
            ),
            Text("Son Kullanma: ${kimyasal.sonkullanmatarihi.toLocal().toString().split(' ')[0]}"),
            Text("Giriş: ${kimyasal.giristarihi.toLocal().toString().split(' ')[0]}"),
            Text("Güncelleme: ${kimyasal.guncellemetarihi.toLocal().toString().split(' ')[0]}"),
            Text(
              "Son kullanma tarihi: ${kimyasal.sonkullanmatarihi}",
            ),
            Text(
              "Birim: ${kimyasal.birim}",
            ),
            Text(
              "Miktar: ${kimyasal.stokmiktari}",
            ),
            Text(
              "Minimum Miktar: ${kimyasal.minimumstok}",
            ),
            Text(
              "Tedarikçi: ${kimyasal.tedarikci}",
            ),
            Text(
              "Tehlike durumu: ${kimyasal.tehlikesinifi}",
            ),
            Text(
              "Lokasyon: ${kimyasal.depolokasyonu}",
            ),
          ],
        ),
      ),
    );
  }
}