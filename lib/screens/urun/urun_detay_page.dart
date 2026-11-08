import 'package:flutter/material.dart';
import '../../models/urun.dart';

class UrunDetayPage extends StatelessWidget {
  final Urun urun;

  const UrunDetayPage({
    super.key,
    required this.urun,
  });

  Widget item(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? "-" : value,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}."
        "${date.month.toString().padLeft(2, '0')}."
        "${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün Detay"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            item("Ürün Tipi", urun.uruntipi),
            item("Parti No", urun.partino.toString()),
            item("Birim", urun.birim),
            item("Miktar", urun.miktar.toString()),
            item("Minimum Stok", urun.minimumstok.toString()),
            item("Açıklama", urun.aciklama),
       

            const Divider(height: 30),

            item("Oluşturma", formatDate(urun.giristarihi)),
            item("Güncelleme", formatDate(urun.guncellemetarihi)),
          ],
        ),
      ),
    );
  }
}