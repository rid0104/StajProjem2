import 'package:flutter/material.dart';
import '../../core/services/stok_service.dart';
import '../../models/stok_item.dart';

class StokPage extends StatefulWidget {
  const StokPage({super.key});

  @override
  State<StokPage> createState() => _StokPageState();
}

class _StokPageState extends State<StokPage> {
  final StokService _service = StokService();

  List<StokItem> items = [];
  StokItem? selected;

  final miktarCtrl = TextEditingController();
  final aciklamaCtrl = TextEditingController();

  String hareketTipi = "giris";
  bool loading = false;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final data = await _service.getAllStockItems();

    setState(() {
      items = data;
  });
}

  Future<void> kaydet() async {
    if (selected == null) return;

    setState(() => loading = true);

    try {
      await _service.stokhareket(
        entityType: selected!.type,
        entityId: selected!.id,
        hareketTipi: hareketTipi,
        miktar: double.parse(miktarCtrl.text),
        aciklama: aciklamaCtrl.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Başarılı")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hata: $e")),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stok Hareket")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            DropdownButtonFormField<StokItem>(
              value: selected,
              items: items
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text("${e.name} (${e.type})"),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => selected = v),
            ),

            DropdownButtonFormField(
              value: hareketTipi,
              items: const [
                DropdownMenuItem(value: "giris", child: Text("Giriş")),
                DropdownMenuItem(value: "cikis", child: Text("Çıkış")),
              ],
              onChanged: (v) => setState(() => hareketTipi = v!),
            ),

            TextField(
              controller: miktarCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Miktar"),
            ),

            TextField(
              controller: aciklamaCtrl,
              decoration: const InputDecoration(labelText: "Açıklama"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: loading ? null : kaydet,
              child: Text(loading ? "Kaydediliyor..." : "Kaydet"),
            )
          ],
        ),
      ),
    );
  }
}