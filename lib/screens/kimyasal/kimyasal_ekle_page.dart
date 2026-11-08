import 'package:flutter/material.dart';
import '../../core/services/kimyasal_service.dart';

class KimyasalEklePage extends StatefulWidget {
  const KimyasalEklePage({super.key});

  @override
  State<KimyasalEklePage> createState() => _KimyasalEklePageState();
}

class _KimyasalEklePageState extends State<KimyasalEklePage> {
  final adCtrl = TextEditingController();
  final kategoriCtrl = TextEditingController();
  final kodCtrl = TextEditingController();
  final stokCtrl = TextEditingController();
  final minCtrl = TextEditingController();
  final tedarikciCtrl = TextEditingController();
  final tehlikeCtrl = TextEditingController();
  final lokasyonCtrl = TextEditingController();
  final birimCtrl = TextEditingController();

  DateTime? sonTarih;

  @override
  void dispose() {
    adCtrl.dispose();
    kategoriCtrl.dispose();
    kodCtrl.dispose();
    stokCtrl.dispose();
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
    );

    if (picked != null) {
      setState(() => sonTarih = picked);
    }
  }

  Future<void> _kaydet() async {
    if (sonTarih == null) return;

    await KimyasalService().create({
      "kimyasaladi": adCtrl.text,
      "kategori": kategoriCtrl.text,
      "kimyasalkodu": int.tryParse(kodCtrl.text) ?? 0,
      "sonkullanmatarihi": sonTarih!.toIso8601String(),
      "birim": birimCtrl.text,
      "stokmiktari": double.tryParse(stokCtrl.text) ?? 0.0,
      "minimumstok": int.tryParse(minCtrl.text) ?? 0,
      "tedarikci": tedarikciCtrl.text,
      "tehlikesinifi": tehlikeCtrl.text,
      "depolokasyonu": lokasyonCtrl.text,
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
      appBar: AppBar(title: const Text("Kimyasal Ekle")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            field(adCtrl, "Kimyasal Adı"),
            field(kategoriCtrl, "Kategori"),
            field(kodCtrl, "Kod", type: TextInputType.number),
            field(birimCtrl, "Birim"),
            field(stokCtrl, "Stok", type: TextInputType.number),
            field(minCtrl, "Minimum Stok", type: TextInputType.number),
            field(tedarikciCtrl, "Tedarikçi"),
            field(tehlikeCtrl, "Tehlike Sınıfı"),
            field(lokasyonCtrl, "Depo Lokasyonu"),

            ListTile(
              title: Text(
                sonTarih == null
                    ? "Son Kullanma Tarihi Seç"
                    : sonTarih!.toIso8601String().split("T").first,
              ),
              trailing: const Icon(Icons.date_range),
              onTap: _pickDate,
            ),

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