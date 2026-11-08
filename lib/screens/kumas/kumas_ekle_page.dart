import 'package:flutter/material.dart';
import '../../core/services/kumas_service.dart';

class KumasEklePage extends StatefulWidget {
  const KumasEklePage({super.key});

  @override
  State<KumasEklePage> createState() => _KumasEklePageState();
}

class _KumasEklePageState extends State<KumasEklePage> {
  final adCtrl = TextEditingController();
  final tipCtrl = TextEditingController();
  final kodCtrl = TextEditingController();
  final partiCtrl = TextEditingController();
  final renkCtrl = TextEditingController();
  final stokCtrl = TextEditingController();
  final depoCtrl = TextEditingController();
  final birimCtrl = TextEditingController();

  @override
  void dispose() {
    adCtrl.dispose();
    tipCtrl.dispose();
    kodCtrl.dispose();
    partiCtrl.dispose();
    renkCtrl.dispose();
    stokCtrl.dispose();
    depoCtrl.dispose();
    birimCtrl.dispose();
    super.dispose();
  }

  Future<void> _kaydet() async {
    await KumasService().create({
      "kumasadi": adCtrl.text,
      "kumastipi": tipCtrl.text,
      "kumaskodu": int.tryParse(kodCtrl.text) ?? 0,
      "partino": int.tryParse(partiCtrl.text) ?? 0,
      "renk": renkCtrl.text,
      "stokmiktari": double.tryParse(stokCtrl.text) ?? 0.0,
      "depolokasyonu": depoCtrl.text,

      "birim": birimCtrl.text,
      "harekettipi": "Giriş",
      "durum": "Aktif",
      "topsayisi": 0,
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
      appBar: AppBar(title: const Text("Kumaş Ekle")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            field(adCtrl, "Kumaş Adı"),
            field(tipCtrl, "Tip"),
            field(kodCtrl, "Kod", type: TextInputType.number),
            field(partiCtrl, "Parti No", type: TextInputType.number),
            field(renkCtrl, "Renk"),
            field(stokCtrl, "Stok", type: TextInputType.number),
            field(depoCtrl, "Depo"),
            field(birimCtrl, "Birim"),

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