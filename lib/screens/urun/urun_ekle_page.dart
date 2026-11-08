import 'package:flutter/material.dart';
import '../../core/services/urun_service.dart';

class UrunEklePage extends StatefulWidget {
  const UrunEklePage({super.key});

  @override
  State<UrunEklePage> createState() => _UrunEklePageState();
}

class _UrunEklePageState extends State<UrunEklePage> {
  final urunCtrl = TextEditingController();
  final partiCtrl = TextEditingController();
  final birimCtrl = TextEditingController();
  final miktarCtrl = TextEditingController();
  final minimumCtrl = TextEditingController();
  final aciklamaCtrl = TextEditingController();


  @override
  void dispose() {
    urunCtrl.dispose();
    partiCtrl.dispose();
    birimCtrl.dispose();
    miktarCtrl.dispose();
    minimumCtrl.dispose();
    aciklamaCtrl.dispose();
   
    super.dispose();
  }

  Future<void> _kaydet() async {
    await UrunService().create({
      "uruntipi": urunCtrl.text,
      "partino": int.tryParse(partiCtrl.text) ?? 0,
      "birim": birimCtrl.text,
      "miktar": double.tryParse(miktarCtrl.text) ?? 0.0,
      "minimumstok": int.tryParse(minimumCtrl.text) ?? 0,
      "aciklama": aciklamaCtrl.text,
   
    });

    if (mounted) Navigator.pop(context, true);
  }

  Widget field(TextEditingController c, String label,
      {TextInputType? type}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ürün Ekle")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            field(urunCtrl, "Ürün Tipi"),
            field(partiCtrl, "Parti No", type: TextInputType.number),
            field(birimCtrl, "Birim"),
            field(miktarCtrl, "Miktar", type: TextInputType.number),
            field(minimumCtrl, "Minimum Stok", type: TextInputType.number),
            field(aciklamaCtrl, "Açıklama"),
    

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _kaydet,
              child: const Text("Kaydet"),
            ),
          ],
        ),
      ),
    );
  }
}