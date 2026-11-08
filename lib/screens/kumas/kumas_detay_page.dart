import 'package:flutter/material.dart';
import '../../models/kumas.dart';

class KumasDetayPage extends StatelessWidget {
  final Kumas kumas;

  const KumasDetayPage({
    super.key,
    required this.kumas,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kumaş Detay"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ad: ${kumas.kumasadi}"),
            Text("Tip: ${kumas.kumastipi}"),
            Text("Kod: ${kumas.kumaskodu}"),
            Text("Renk: ${kumas.renk}"),
            Text("Stok: ${kumas.stokmiktari}"),
            Text("Depo: ${kumas.depolokasyonu}"),
            Text("Parti No: ${kumas.partino}"),
            Text("Giriş: ${kumas.giristarihi.toLocal().toString().split(' ')[0]}"),
            Text("Güncelleme: ${kumas.guncellemetarihi.toLocal().toString().split(' ')[0]}"),
            Text("Renk: ${kumas.renk}"),
            Text("Birim: ${kumas.birim}"),
            Text("Top Sayısı: ${kumas.topsayisi}"),
            Text("Durum: ${kumas.durum}"),
        
    
          ],
        ),
      ),
    );
  }
}