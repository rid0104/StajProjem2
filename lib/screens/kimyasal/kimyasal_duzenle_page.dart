import 'package:flutter/material.dart';
import '../../models/kimyasal.dart';
import '../../core/services/kimyasal_service.dart';

class KimyasalDuzenlePage extends StatefulWidget {
  final Kimyasal kimyasal;

  const KimyasalDuzenlePage({super.key, required this.kimyasal});

  @override
  State<KimyasalDuzenlePage> createState() =>
      _KimyasalDuzenlePageState();
}

class _KimyasalDuzenlePageState extends State<KimyasalDuzenlePage> {
  late TextEditingController adCtrl;
  late TextEditingController kategoriCtrl;
  late TextEditingController kodCtrl;
  late TextEditingController minCtrl;
  late TextEditingController tedarikciCtrl;
  late TextEditingController tehlikeCtrl;
  late TextEditingController lokasyonCtrl;
  late TextEditingController birimCtrl;

  DateTime? tarih;

  @override
  void initState() {
    super.initState();

    adCtrl = TextEditingController(text: widget.kimyasal.kimyasaladi);
    kategoriCtrl = TextEditingController(text: widget.kimyasal.kategori);
    kodCtrl = TextEditingController(text: widget.kimyasal.kimyasalkodu.toString());
    minCtrl = TextEditingController(text: widget.kimyasal.minimumstok.toString());
    tedarikciCtrl = TextEditingController(text: widget.kimyasal.tedarikci);
    tehlikeCtrl = TextEditingController(text: widget.kimyasal.tehlikesinifi);
    lokasyonCtrl = TextEditingController(text: widget.kimyasal.depolokasyonu);
    birimCtrl = TextEditingController(text: widget.kimyasal.birim);

    tarih = widget.kimyasal.sonkullanmatarihi;
  }

  @override
  void dispose() {
    adCtrl.dispose();
    kategoriCtrl.dispose();
    kodCtrl.dispose();
    minCtrl.dispose();
    tedarikciCtrl.dispose();
    tehlikeCtrl.dispose();
    lokasyonCtrl.dispose();
    birimCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: tarih ?? DateTime.now(),
    );

    if (picked != null) {
      setState(() => tarih = picked);
    }
  }

 Future<void> _guncelle() async {
  if (tarih == null) return;

  await KimyasalService().update(widget.kimyasal.id, {
    "kimyasaladi": adCtrl.text,
    "kategori": kategoriCtrl.text,
    "kimyasalkodu": int.tryParse(kodCtrl.text) ?? 0,
    "minimumstok": int.tryParse(minCtrl.text) ?? 0,
    "tedarikci": tedarikciCtrl.text,
    "tehlikesinifi": tehlikeCtrl.text,
    "depolokasyonu": lokasyonCtrl.text,
    "birim": birimCtrl.text,
    "sonkullanmatarihi": tarih!.toIso8601String(),
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
      appBar: AppBar(title: const Text("Kimyasal Düzenle")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            field(adCtrl, "Ad"),
            field(kategoriCtrl, "Kategori"),
            field(kodCtrl, "Kod", type: TextInputType.number),
            field(birimCtrl, "Birim"),
            field(minCtrl, "Minimum Stok", type: TextInputType.number),
            field(tedarikciCtrl, "Tedarikçi"),
            field(tehlikeCtrl, "Tehlike Sınıfı"),
            field(lokasyonCtrl, "Depo Lokasyonu"),

            ListTile(
              title: Text(
                tarih?.toIso8601String().split("T").first ?? "Tarih seç",
              ),
              trailing: const Icon(Icons.date_range),
              onTap: _pickDate,
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guncelle,
              child: const Text("Güncelle"),
            ),
          ],
        ),
      ),
    );
  }
}